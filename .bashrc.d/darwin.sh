function _setup_brew_env() {
  # Check if Homebrew is installed
  # if [[ -z "$(command -v brew)" ]]; then
  #   _warning "Homebrew is not installed. Installing now..."
  #   export HOMEBREW_NO_INSTALL_FROM_API=1
  #   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  #   if [[ $? -ne 0 ]]; then
  #     _error "Homebrew installation failed."
  #     return 1
  #   fi
  # fi
  # local brew_path="$(command -v brew)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

_setup_brew_env