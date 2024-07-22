[[ -z "$GHCUP_ROOT" ]] && export GHCUP_ROOT="$HOME/.ghcup"

# Adjust PATH
export PATH="$GHCUP_ROOT/bin:$PATH"

_zsh_ghcup_install() {
    echo "Installing ghcup..."

    # For Debian-based systems, ensure build tools are present.
    # We're going to skip this because can't do sudo silently.
    # if command -v apt &> /dev/null; then
    #  sudo apt install -y build-essential curl libffi-dev libffi8ubuntu1 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5
    # fi

    if command -v curl &> /dev/null; then
      # curl --proto '=https_' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
      curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 BOOTSTRAP_HASKELL_GHC_VERSION=latest BOOTSTRAP_HASKELL_CABAL_VERSION=latest BOOTSTRAP_HASKELL_INSTALL_STACK=1 BOOTSTRAP_HASKELL_INSTALL_HLS=1 BOOTSTRAP_HASKELL_ADJUST_BASHRC=P sh
    else
      echo "cannot install GHCup: missing curl command"
      exit 1
    fi
}

_zsh_ghcup_load() {
    source $GHCUP_ROOT/env
}

# Download and install GHCup if it doesn't exist
if ! command -v ghcup &>/dev/null; then
    _zsh_ghcup_install
fi

# Initialize ghcup if it does exist
if command -v ghcup &>/dev/null; then
    _zsh_ghcup_load
fi

