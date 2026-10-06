# OpenDesign Nix Flake

Installation of [OpenDesign](https://github.com/nexu-io/open-design) on NixOS made easy by wrapping the official Docker image into a flake.

## Usage

Add the flake to your `flake.nix` inputs:

```nix
{
  inputs.opendesign.url = "github:YOUR_ORG/opendesign-nix";
  # ...
}
```

Then in your NixOS configuration (e.g. `configuration.nix`), import the module and enable it.

```nix
{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.opendesign.nixosModules.default
  ];

  services.open-design = {
    enable = true;
    
    # Optional: override the default port (7456)
    # port = 7456; 
  };
}
```

## Options

- `services.open-design.enable`: Enable the OpenDesign container.
- `services.open-design.port`: Host port to bind to on `127.0.0.1` (default: `7456`).

## How it works
Uses the powerful `virtualisation.oci-containers` to run the official OpenDesign Docker image which automatically takes care of everything really.

## Why i made it
Simple, OpenDesign is a powerful tool but doesn't exist on NixOS, at least not in an easy fast way to install. So here is that way.
Also just because I hate cluttering my own configs so this keeps them more modular and easy to understand.