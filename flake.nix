{
  description = "NixOS module for OpenDesign";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules.default = import ./module.nix;
    nixosModules.open-design = self.nixosModules.default;
  };
}
