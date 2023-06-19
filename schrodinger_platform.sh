# Mac specific:

# Schrodinger specific environment variables
function select-build() {
    [[ -n "$1" ]] || echo "select-build needs an argument (e.g. select-build 2021-3)"
    branch=$1;
    export SCHRODINGER_SRC=/Users/$USER/builds/$branch/source;
    export SCHRODINGER=/Users/$USER/builds/$branch/build;
    export SCHRODINGER_LIB=/Users/$USER/builds/software/lib
    export INTEL_LICENSE_FILE=28518@nyc-lic-intel.schrodinger.com
}

# Aliases
alias maestro='${SCHRODINGER}/maestro -console'
alias designer='open $QTDIR/bin/Designer.app'  # Source the build environment to set QTDIR