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

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}

