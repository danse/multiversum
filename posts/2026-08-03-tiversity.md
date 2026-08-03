# Building tiversify: a session in documentation-first development

We just spent a working session turning a two-document blueprint into a
working tool. The project is **tiversify**: it looks at the accounts you
follow on X, measures how many messages each one posted in the last 24
hours, and reports the accounts that fill your feed the most. If your
timeline reads like a single loudspeaker, tiversify is a way to notice.

This post is a recap of how the session went, because the shape of the
work was almost more interesting than the code itself: we developed
documentation-first, and we started from a skeletal logic module.

## Documentation first

The repository began with `README.md` and `development.md` — nothing
else. Those two files described the whole intended architecture:

- pure business logic in `app/Business.hs`
- X-specific calls (OAuth 1.0a signing, X API v2 endpoints) in `app/X.hs`
- a thin executable entry point in `app/Main.hs`

The interesting part is that **none of those files existed yet**. The
docs were the blueprint, and the code was meant to be written into the
places the docs had already reserved. When we started, the only real
source file was the skeletal `Business.hs` that the blueprint pointed
at. The plan came first; the implementation followed the plan.

This is a nice way to work on a small tool: the contract between modules
was decided before any of them were written, which meant we never had to
"refactor our way" to an architecture. The architecture was already on
paper.

## The skeletal logic module

The original `Business.hs` was exactly what you'd expect from a
blueprint — a skeleton. It had the right vocabulary:

- `Account`, an account identified by a handle
- `Output`, how many messages an account sent in the last 24 hours
- `Rate`, the share of messages each account contributes
- `Percent`, a smart-constructed share in `[0, 1]`
- `computeRates`, turning a list of outputs into rates

But it was a *skeleton* in the literal sense: it did not compile. A
`newtype` with two fields, `NoFieldSelectors` breaking field access, a
missing `Ord` instance for `Percent`, and a `percent` function whose type
promised one thing while `computeRates` assumed another.

Rebuilding it was the most satisfying part of the session. We reduced it
to pure logic with no `IO` and no `undefined` anywhere — just types, a
smart constructor, and a `Show` instance that renders the report. Pure
code is easy to test, and later we did exactly that, printing reports
with varying limits to check the formatting without ever touching the
network.

## The X integration: OAuth 1.0a by hand

The centerpiece was authenticating with the X API v2. We implemented
OAuth 1.0a user-context signing ourselves: RFC 3986 percent-encoding, a
carefully assembled signature base string, HMAC-SHA1 over the
`consumer_secret & access_secret` key, and the `Authorization` header.

This was documentation-first again, at the protocol level. The RFC 5849
spec was our source of truth, and we wrote a small independent Python
implementation as an oracle to check our signatures against. (A funny
detail: RFC 5849's own worked example is internally inconsistent, so we
validated against realistic inputs instead of the spec's example.)

Three hand-picked signature cases matched the Python reference exactly.

## The 401 that taught us the value of the oracle

The first live run came back `401 Unauthorized`. Our signature matched
our own Python reference, so what was wrong?

We signed the same request with `oauthlib`, a battle-tested library.
With identical credentials and the same URL, `oauthlib` sailed past
authentication — it got `402 credits depleted`, which is a billing
condition, not an auth failure. The credentials were fine. The
difference was in the `Authorization` header format: we were sending
unquoted, `&`-separated parameters, but RFC 5849 §3.5.1 requires quoted,
comma-separated ones. One-line fix, and our binary behaved identically
to `oauthlib`.

The moral: build an independent oracle before you touch the live system,
and compare against it when something misbehaves.

## The fine print

X now charges per-call credits, so live testing has a real budget. The
API answered "credits depleted" when the account ran dry — which is why
a lot of our verification happened without network calls at all:
`--help` output, usage errors, and pure report rendering.

## Polish passes

Once the core worked, we tightened the tooling:

- a `--verbose` flag that logs every API call (URL and query) to
  stderr, leaving the report on stdout clean
- a single shared HTTP `Manager` — one TLS connection pool instead of a
  fresh one per request
- `optparse-applicative` replacing a hand-rolled argument parser
- a `-n/--limit` option to choose how many accounts to show, which made
  the `Int` a field of `Report` (a nice example of the data following
  the feature)

We also tripped over the usual Haskell ecosystem quirks — the current
`http-client` API, `aeson` 2.x's `KeyMap`, and `crypton` pulling in
`ram` instead of `memory`. All of it handled.

## What I'd repeat

Documentation first meant we knew where everything lived before we wrote
it. A skeletal logic module gave us a shape to fill in rather than a
blank page. And an independent signature oracle turned a confusing `401`
into a one-line fix. The proof came at the end: a full end-to-end run —
following list, every account's 24-hour volume, and the final report —
for about $5 in X API credits. A good session, and a working tool.
