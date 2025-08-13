{ config, pkgs, inputs, ... }:

{
	imports =
		[
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


	networking.hostName = "nixos";
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

		nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
	networking.networkmanager.enable = true;

	time.timeZone = "Asia/Kolkata";
	i18n.defaultLocale = "en_IN";
	i18n.extraLocaleSettings = {
		LANG = "en_US.UTF-8";
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


# Enable the GNOME Desktop Environment.
# services.xserver.displayManager.gdm.enable = true;
# services.xserver.desktopManager.gnome.enable = true;

# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable bluetooth
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

# Enable sound with pipewire.
	services.pulseaudio.enable = false;
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

	programs.zsh.enable = true;
	users.users.khush = {
		isNormalUser = true;
		description = "Khush Patibandha";
		extraGroups = [ "networkmanager" "wheel" "input" "docker" ];
		shell = pkgs.zsh;
		packages = with pkgs; [
#  thunderbird
		];
	};


	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		home-manager

			ghostty

			tmux
			vim
			neovim
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
			delve #debugger

# LSPs
			lua-language-server
			jdt-language-server
			haskell-language-server
			gopls

# Browsers
			google-chrome
			brave

# Music Players
			spotify
			strawberry
			# vlc

# Terminal Music Players	
			rmpc
			ncmpcpp
			mpc # dependency - Music Player Client
			mpd # dependency - Music Player Daemon

			jdk17
			python3
			nodejs_20
			go
			ghc
			maven

# utils
			zip
			unzip
			discord
			direnv
			dconf
			gemini-cli
			stremio # watching movies
			baobab # for showing disk storage
			libreoffice # word of linux
			oh-my-posh # for the terminal line
			appimage-run # for extracting appimage files
			screenkey # for screencasting keyboard presses on screen
			flameshot # screenshot tool
			droidcam # webcam
			ffmpeg-full # ffmpeg for video and audio processing because why not?
			redshift # to save my eyes at night
			bc # basic calculation (required for polybar)
			pavucontrol # for audio stuff
			ripgrep # required for nvim
			fd # required for nvim (optional)
			gimp # for drawing stuff
			obs-studio # for recording
			fzf # for fuzzy searching
			btop # for system usage
			postman # for api testing
			hyperfine # for testing
			ollama # for installing llm locally
			fastfetch # for showoff system
			killall # for keyboard remapping
			xcape # for keyboard remapping

# for connecting iphone
			ifuse
			usbmuxd
			libimobiledevice

# xorg stuff
			xorg.xhost
			xorg.xinput
			xorg.libX11

			# font-awesome
			# gh
			# sqlite
			# mysql-workbench
			# gnome-keyring
			];

	services.xserver.enable = true;
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};
	services.ollama = {
		enable = true;
	};
	services.usbmuxd.enable = true;
	services.openssh.enable = true;
	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
		settings.mysqld.port = 3306;
	};

	programs.nix-ld.enable = true;
	programs.firefox.enable = true;

	virtualisation.docker.enable = true;

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
