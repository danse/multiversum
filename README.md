In order to have `zlib` available reliably for Haskell, i defined a
Nix environment like in [this
example](https://nixos.org/wiki/Development_Environments#SDL_Example). In
order to use it, type:

    $ nix-shell

At this point the site can be rebuilt with the commands:

    $ cabal sandbox init
    $ cabal install
    $ cabal run site clean
    $ cabal run site build

##### Deploy

Hakyll leaves the built assets under a `_site` folder. That folder is
ignored in the `master` branch, while on the parent directory i have a
different Git repo pointing to `master` at
<https://github.com/danse/danse.github.io>. Thus, after a build, i can
use the deploy script included in this repo:

    $ . deploy.sh
