{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		ghostty = {
			url = "github:ghostty-org/ghostty";
		};
	};

	outputs = { self, nixpkgs, home-manager, ghostty, ... }@inputs: 
		let 
		system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	in 
	{
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				./hosts/default/configuration.nix
				inputs.home-manager.nixosModules.default
				{
					environment.systemPackages = with pkgs; [
						ghostty.packages.${system}.default
					];
				}
			];
		};
	};
}
