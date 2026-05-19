{
  description = "Basic Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      supportSystems = with flake-utils.lib.system; [
        x86_64-linux
        aarch64-darwin
      ];
    in
    flake-utils.lib.eachSystem supportSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate =
            pkg:
            builtins.elem (pkg.lib.getName pkg) [
            ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
          ];
        };
      }
    );
}
