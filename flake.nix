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
              ./patches/0001-Disable-premium-nags.patch
              ./patches/0002-Never-show-promo-suggestions.patch
              ./patches/0003-Hide-AI-button.patch
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
