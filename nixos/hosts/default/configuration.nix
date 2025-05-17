# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
# ./hardware-acceleration.nix
			../i3wm/i3.nix
			inputs.home-manager.nixosModules.default
		];

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.extraModulePackages = with config.boot.kernelPackages; [
		v4l2loopback
	];

	boot.kernelModules = [ "v4l2loopback" "uinput" ];

	boot.extraModprobeConfig = ''
		options v4l2loopback devices=1 video_nr=10 card_label="DroidCam" exclusive_caps=1
		'';


	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

		nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
	networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "Asia/Kolkata";

# Select internationalisation properties.
	i18n.defaultLocale = "en_IN";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_IN";
		LC_IDENTIFICATION = "en_IN";
		LC_MEASUREMENT = "en_IN";
		LC_MONETARY = "en_IN";
		LC_NAME = "en_IN";
		LC_NUMERIC = "en_IN";
		LC_PAPER = "en_IN";
		LC_TELEPHONE = "en_IN";
		LC_TIME = "en_IN";
	};

# Enable the X11 windowing system.
	services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
# services.xserver.displayManager.gdm.enable = true;
# services.xserver.desktopManager.gnome.enable = true;

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable bluetooth
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
	};

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	programs.zsh.enable = true;
	users.users.khush = {
		isNormalUser = true;
		description = "Khush Patibandha";
		extraGroups = [ "networkmanager" "wheel" "input" ];
		shell = pkgs.zsh;
		packages = with pkgs; [
#  thunderbird
		];
	};

# Install firefox.
	programs.firefox.enable = true;

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		home-manager

			ghostty
			xterm

			vim
			neovim
			vscode
			git
			gcc

# c/cpp
			clang
			clang-tools
			cmake

# java
			google-java-format

# lua
			stylua

# go
			gofumpt
			goimports-reviser
			golangci-lint
			gomodifytags
			impl

# LSPs
			lua-language-server
			jdt-language-server
			gopls

			discord
			google-chrome
			brave
			postman
			strawberry
			spotify

			php83
			jdk17
			python3
			nodejs_20
			go
			maven

			python312Packages.xlib
			screenkey

			hyperfine
			flameshot
			libreoffice
			mysql-workbench
			gnome-keyring
# sqlite
			droidcam
			direnv
			ollama
			fastfetch
			gimp
			vlc
			obs-studio
			killall
			fzf
			btop
			xcape
			ripgrep
			fd
			gh
			ffmpeg-full
			redshift
			ifuse
			usbmuxd
			libimobiledevice
			bc
			pavucontrol
			dconf
			zip
			unzip
			font-awesome
			oh-my-posh
			appimage-run
			xorg.xhost
			xorg.xinput
			xorg.libX11
			xorg.libXtst
			xorg.libXi
			];

	services.ollama = {
		enable = true;
	};
	services.usbmuxd.enable = true;

	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
	};

	programs.nix-ld.enable = true;

	home-manager = {
		extraSpecialArgs = { inherit inputs;  };
		users = {
			"khush" = import ./home.nix;
		};
	};

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?
}
