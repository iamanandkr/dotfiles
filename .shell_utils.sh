# ==============================================================================
# This file contains utility functions for bash scripts.
# ==============================================================================

# ==============================================================================
# Platform Detection
# ==============================================================================

function _is_darwin() {
    [[ $(uname) == "Darwin" ]]
}

function _is_linux() {
    [[ $(uname) == "Linux" ]]
}

function _is_windows() {
    [[ $(uname) == *"MINGW"* ]]
}


# ==============================================================================
# Basic Logging
# ==============================================================================

function _debug() {
    echo -e "\033[0;34m$1\033[0m"  # Blue color
}

function _info() {
    echo -e "\033[0;35m$1\033[0m"  # Magenta color
}

function _warning() {
    echo -e "\033[0;33m$1\033[0m"  # Yellow color
}

function _error() {
    echo -e "\033[0;31m$1\033[0m"  # Red color
}

function _success() {
    echo -e "\033[0;32m$1\033[0m"  # Green color
}


# ==============================================================================
# Open text files.
# ==============================================================================

# Open a text file with the default editor. Default editor is VS Code, if
# available. Otherwise, it is vim. If vim is not available, then the file is
# opened with the default application.
# Usage: _open_text_file <file>

function _open_text_file() {
    # check if code or nvim command is available
    if command -v code &> /dev/null; then
        code "$1"
    elif command -v nvim &> /dev/null; then
        nvim "$1"
    elif _is_darwin; then
        open "$1"
    elif _is_linux; then
        xdg-open "$1"
    elif _is_windows; then
        start "$1"
    else
        _error "Unsupported platform."
    fi
}