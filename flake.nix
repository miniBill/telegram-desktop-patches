{
  description = "Patched telegram-desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (_: {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "i686-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem =
        { pkgs, ... }:
        let
          telegram-desktop-unwrapped = pkgs.telegram-desktop.unwrapped.overrideAttrs (orig: {
            patches = (orig.patches or [ ]) ++ [
              ./patches/hide-premium.patch
              ./patches/never-show-promo-suggestions.patch
              ./patches/hide-ai-button.patch
            ];
          });
        in
        {
          packages.telegram-desktop = pkgs.telegram-desktop.override ({
            unwrapped = telegram-desktop-unwrapped;
          });
        };
    });
}
