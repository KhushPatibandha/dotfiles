{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        claude-code.url = "github:sadjow/claude-code-nix";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
        let 
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in 
        {
            nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                    host = "pc";
                };
                modules = [
                    ./hosts/default/configuration.nix
                ];
            };

            nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                    host = "laptop";
                };
                modules = [
                    ./hosts/default/configuration.nix
                ];
            };
        };
}
