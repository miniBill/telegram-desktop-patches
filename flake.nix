{
  description = "Patched telegram-desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux.telegram-desktop-unwrapped =
        nixpkgs.legacyPackages.x86_64-linux.telegram-desktop.unwrapped.overrideAttrs
          (orig: {
            patches = (orig.patches or [ ]) ++ [
              ./patches/hide-premium.patch
              ./patches/never-show-promo-suggestions.patch
              ./patches/hide-ai-button.patch
            ];
          });

      packages.x86_64-linux.telegram-desktop =
        nixpkgs.legacyPackages.x86_64-linux.telegram-desktop.override
          ({
            unwrapped = self.packages.x86_64-linux.telegram-desktop-unwrapped;
          });

      packages.x86_64-linux.default = self.packages.x86_64-linux.telegram-desktop;
    };
}
