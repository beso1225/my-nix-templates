# my-nix-templates

Nix flake templates for project-local development environments.

## Templates

- `basic`: An empty development shell.
- `rust`: Rust with Cargo, rust-analyzer, and binary utilities.
- `haskell`: GHC/GHCi, cabal-install, and haskell-language-server from one Haskell package set.

Initialize a project with a template, for example:

```console
nix flake init --template github:beso1225/my-nix-templates#haskell
nix develop
```

Each template supports `x86_64-linux` and `aarch64-darwin`. If direnv is installed, run `direnv allow` to load the development shell automatically.

## Validation

Run the Haskell template integration check with:

```console
./tests/check-haskell-template.sh
```
