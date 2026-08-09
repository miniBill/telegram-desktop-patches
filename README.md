# telegram-desktop-patches
This is a set of patches (3 at the moment) to remove/hide things I find annoying in Telegram Desktop.

The patches currently target 6.8.1 but should apply cleanly on more recent versions.

## What it removes
- The `Ai` button in the message input;
- anything locked by premium (premium emojis you can’t use, giving stars),
  - as far as I can guess this won’t hide premium emojis used by other people, but I don’t know how to test it;
- promo/suggestions - like the nag to add your birthday.

## What it doesn't remove
- Sponsored posts/messages, as it would be against Telegram’s terms of service.

## How to use it

### NixOS
In your `flake.nix`:

```nix
{
  inputs = {
    # ...
    
    telegram-desktop-patches = {
      url = "github:miniBill/telegram-desktop-patches";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ...
}
```

In your `configuration.nix` or `home-manager.nix`:

```nix
{
  pkgs,
  lib,
  config,
  telegram-desktop-patches,
  # ...
  ...
}:

{ 
  # home-manager.nix
  home.packages = [
    # ...
    telegram-desktop-patches.outputs.packages.${stdenv.hostPlatform.system}.telegram-desktop
  ];

  # configuration.nix
  environment.systemPackages = [
    telegram-desktop-patches.outputs.packages.${stdenv.hostPlatform.system}.telegram-desktop
  ];
}
```

### Non NixOS
I unfortunately don’t currently have more detailed instructions than “Download the patches, apply them to the official Telegram Desktop repository”, PRs are welcome.
