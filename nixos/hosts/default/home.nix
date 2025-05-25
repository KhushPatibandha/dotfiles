{ config, pkgs, ... }:

{
	home.username = "khush";
	home.homeDirectory = "/home/khush";

	home.stateVersion = "24.05"; # Please read the comment before changing.
		home.packages = [
		];

	home.file = {
	};

	home.sessionVariables = {
	};
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		history = {
			size = 10000;
			path = "${config.xdg.dataHome}/zsh/history";
		};
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "direnv"];
			theme = "robbyrussell";
		};
		initExtra = ''
# Custom script here
			eval "$(oh-my-posh init zsh --config ~/oh-my-posh.omp.json)"
			export EDITOR=nvim
			alias gits='git status'
			alias gita='git add'
			alias gitc='git commit -m'
			alias gitp='git push'
			alias gitf='git fetch'
			alias gitpu='git pull'
			alias gitch='git checkout'
			alias giti='git init'
			alias gitb='git branch'
			alias gitsth='git stash'
			alias gitsthp='git stash pop'
			alias gitd='git diff'
			alias gitl='git log'
			alias got='go test'
			alias gor='go run'
			alias btop='btop --force-utf'
			bindkey -s '^F' 'fzf\n'
			bindkey -s '^O' 'fzf | xargs nvim\n'

			setxkbmap -option caps:ctrl_modifier -option grp:shifts_toggle
			killall xcape
			xcape  -e 'Caps_Lock=Escape'
			source <(fzf --zsh)
			'';
	};

	services.mpd = {
		enable = true;
		musicDirectory = "/home/khush/Music/basicallyMyMusicTaste";
		playlistDirectory = "/home/khush/Music/basicallyMyMusicTaste";
		network.listenAddress = "127.0.0.1";
		network.port = 6600;

		extraConfig = ''
			db_file                "~/.config/mpd/database.db"
			log_file               "~/.config/mpd/log"
			pid_file               "~/.config/mpd/pid"
			state_file             "~/.config/mpd/state"
			sticker_file           "~/.config/mpd/sticker.sql"

			auto_update            "yes"
			follow_outside_symlinks "yes"
			follow_inside_symlinks  "yes"

			audio_output {
				type        "alsa"
				name        "PipeWire ALSA"
				device      "pipewire"
				mixer_type  "software"
			}

			audio_output {
				type        "pulse"
				name        "MPD Pulse Output"
				mixer_type  "software"
			}

			replaygain             "album"
			replaygain_preamp      "0"
			'';
	};


# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}

