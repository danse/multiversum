In order to have `zlib` available reliably for Haskell, i defined a
Nix environment like in [this
example](https://nixos.org/wiki/Development_Environments#SDL_Example). In
order to use it, type:

    $ nix-shell .

At this point the site can be rebuilt with the commands:

    $ cabal sandbox init
    $ cabal install
    $ cabal run site build
