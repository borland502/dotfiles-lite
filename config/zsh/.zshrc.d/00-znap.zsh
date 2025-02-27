# Znap works a bit better than zinit for lego assembly reasons
mkdir -p ~/Development/github
[[ -r ~/Development/github/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Development/github/znap
source ~/Development/github/znap/znap.zsh  # Start Znap

# Source all files in ~/.zshrc.d
mkdir -p ~/.zshrc.d

