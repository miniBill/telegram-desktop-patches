{
  description = "Patched tdesktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux.telegram-desktop-unwrapped =
        pkgs:
        pkgs.telegram-desktop.unwrapped.overrideAttrs (orig: {
          patches = (orig.patches or [ ]) ++ [
            ./patches/hide-premium.patch
            ./patches/never-show-promo-suggestions.patch
            ./patches/hide-ai-button.patch
          ];
        });
      packages.x86_64-linux.telegram-desktop =
        let

          telegram-desktop-with-patches =
            pkgs:
            pkgs.telegram-desktop.override ({
              unwrapped = self.packages.x86_64-linux.telegram-desktop-unwrapped pkgs;
            });
        in
        telegram-desktop-with-patches nixpkgs.legacyPackages.x86_64-linux;
      packages.x86_64-linux.default = self.packages.x86_64-linux.telegram-desktop-unwrapped nixpkgs.legacyPackages.x86_64-linux;
    };
}
