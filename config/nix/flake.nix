{
  description = "Jeremy Hettenhouser's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    user = "jhettenh";
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
          [ 
            pkgs.age
            pkgs.ansible
            pkgs.bat
            pkgs.btop
            pkgs.cowsay
            pkgs.curl
            pkgs.dasel
            pkgs.eza
            pkgs.fd
            pkgs.fzf
            pkgs.gh
            pkgs.git
            pkgs.go-task
            pkgs.gomplate
            pkgs.gum
            pkgs.jq
            pkgs.ncdu
            pkgs.nmap
            pkgs.p7zip
            pkgs.pipx
            pkgs.pyenv
            pkgs.ripgrep
            pkgs.rsync
            pkgs.sd
            pkgs.sshpass
            pkgs.starship
            pkgs.tldr
            pkgs.vim
            pkgs.watch
            pkgs.wget
            pkgs.yq
            pkgs.zip
            pkgs.zoxide
            pkgs.zsh           
          ];
      environment.variables = {};

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
      ];

      # TODO: Create nix file for this
      homebrew = {
       enable = true;
        
        taps = [
          "aws/tap"
          "go-task/tap"
          "homebrew/services"
          "kionsoftware/tap"
          "macos-fuse-t/cask"
          "spring-cli-projects/spring-cli"
        ];
        brews = [
          "angular-cli"
          "aws-console"
          "aws-sam-cli"
          "awscli"
          "awslogs"
          "checkov"
          "chezmoi"
          "colima"
          "coreutils"
          "diff-so-fancy"
          "docker"
          "docker-buildx"
          "docker-compose"
          "docker-credential-helper"
          "docker-credential-helper-ecr"
          "direnv"
          "jbang"
          "kionsoftware/tap/kion-cli"
          "nvm"
          "starship"
          ];
        casks = [
          "1password"
          "android-platform-tools"
          "chromium"
          "dbeaver-community"
          "discord"
          "flameshot"
          "font-fira-code-nerd-font"
          "font-fira-mono-nerd-font"
          "fuse"
          "fuse-t"
          "fuse-t-sshfs"
          "gimp"
          "git-credential-manager"
          "gitkraken"
          "keepassxc"
          "kitty"
          "knockknock"
          "moonlight"
          "obsidian"
          "openoffice"
          "pgadmin4"
          "powershell"
          "session-manager-plugin"
          "slack"
          "springtoolsforeclipse"
          "tomatobar"
          "virtualbox"
          "vivaldi"
          "wezterm"
          "yubico-yubikey-manager"
          "zoom"          
        ];
      };
      # When doing system activation upgrade Homebrew packages, but purge any that are no longer installed.
      homebrew.onActivation = {
        cleanup = "zap";
        upgrade = true;
      };
      
      networking.knownNetworkServices = ["USB 10/100/1000 LAN" "Wi-Fi"];
      networking.search = [ "technohouser.com" "hettenhouser.com" ];
      networking.wakeOnLan.enable = true;

      # Add this line if you're using the Determinate Systems installer
      nix.enable = false;

      # Shell customizations
      programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableBashCompletion = true;
        enableCompletion = true;
        enableFastSyntaxHighlighting = true;
        enableFzfCompletion = true;
        enableFzfHistory = true;
        # needed until zsh completion plugins are phased out
        enableGlobalCompInit = false;
      };

      # Enable Touch ID for sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      system.primaryUser = "jhettenh";

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."ICFC9DWH494TM-2" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
