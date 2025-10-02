{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: 
		let 
		system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	in 
	{
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				./hosts/default/configuration.nix
			];
		};
	};
}
