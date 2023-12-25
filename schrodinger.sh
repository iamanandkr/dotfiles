# Load platform specific features
[ -f ~/schrodinger_platform.sh ] && source ~/schrodinger_platform.sh

# Create aliases for all releases.
echo "Creating release aliases..."
for dir in $(find /Users/$USER/builds -maxdepth 1 -type d -name "[0-9][0-9][0-9][0-9]-[0-9]"); do
    alias_name=$(echo $dir | awk -F'/' '{print $NF}')
    alias ${alias_name:2}="select-build $alias_name"
    echo ${alias_name:2} for $alias_name
done


# Easy navigation for Schrodinger paths
alias src='cd $SCHRODINGER_SRC'
alias mm='cd ${SCHRODINGER_SRC}/mmshare'
alias ss='cd ${SCHRODINGER_SRC}/scisol-src'

alias bld='cd $SCHRODINGER'
alias mmb='cd ${SCHRODINGER}/mmshare-v*/'
alias mmt='cd ${SCHRODINGER}/mmshare-v*/python/test'
alias ssb='cd ${SCHRODINGER}/scisol-v*/'

alias mmss='mmb && make python && ssb && make all'


# Schrodinger command
alias srun='${SCHRODINGER}/run'
alias sjsc='${SCHRODINGER}/jsc'


# Build specific
alias ssch='source $SCHRODINGER_SRC/mmshare/build_env'
alias mps='cd $SCHRODINGER/mmshare-v*/ && make python-scripts && cd -'
alias mpm='cd $SCHRODINGER/mmshare-v*/ && make python-modules && cd -'
alias mmlog='tail $SCHRODINGER/mmshare-v*/make_mmshare_all.log'
alias maelog='tail $SCHRODINGER/maestro-v*/make_maestro-src_all.log'


# Background builder
alias bg-builder='srun $SCHRODINGER_SRC/mmshare/build_tools/background_builder.py'
alias pyrun='srun $SCHRODINGER_SRC/mmshare/build_tools/background_run.py'
alias autorun='srun $SCHRODINGER_SRC/mmshare/build_tools/autobuild.py'
alias pymaestro='srun $SCHRODINGER_SRC/mmshare/build_tools/background_run.py maestro'

# Get next build number in the branch
function mmv() {
    bld=${1:-master}
    curl -s "https://cgit.schrodinger.com/cgit/mmshare/plain/version.h?h=$bld" | grep "#define MMSHARE_VERSION" | awk '{ printf("%03d\n", $3%1000+1) }'
}

function switch_sdgr_branches() {
    # Switch all repos in $SCHRODINGER_SRC to the specified branch.
    if [[ -z $1 ]]; then
        echo "Specify branch to checkout..."
        return 1
    fi

    if [[ -z "${SCHRODINGER_SRC}" ]]; then
        echo '$SCHRODINGER_SRC is not set.'
        return 1
    fi

    echo -e '$SCHRODINGER_SRC is set to: ' $SCHRODINGER_SRC '\n'

    echo -e "Process and update repositories:\n"
    for repo in $SCHRODINGER_SRC/*; do
        echo "Processing" $repo "..."
        git -C $repo fetch; git -C $repo checkout $1;
        if [[ $? -ne 0 ]]; then
            RED='\033[0;31m'
            NC='\033[0m' # No Color
            echo -e "${RED}Error checking out $1 in $repo. Is this a Schrodinger suite repo?${NC}"
        fi
        echo -e "\n          ***********************************************\n"
    done;
}


# make test TEST_ARGS
function mtest() {
    if [ $# -gt 0 ]; then
        args="${*}"
        # If running scisol gui tests, then run it as post-test
        if [[ $args == *"fep_gui"* ]]; then
            args="--post-test $args"
        fi
        make test TEST_ARGS="$args"
    else
        make test
    fi
}


function spost_buildinger() {
    echo "Copy Qt pyi files to schrodinger/Qt"
    cp -f $(find $SCHRODINGER_LIB -name *.pyi) $SCHRODINGER/internal/lib/python*/site-packages/schrodinger/Qt > /dev/null 2>&1

    echo "symlink: scisol-src modules in site-packages/schrodinger/application/scisol/packages"
    if [ -d $SCHRODINGER/scisol-v* ]; then
        # if scisol is installed then symlink scisol-src modules
        ln -s -f $SCHRODINGER/scisol-v*/lib/*/python_packages/scisol/*/ $SCHRODINGER/internal/lib/python3.8/site-packages/schrodinger/application/scisol/packages > /dev/null 2>&1
    fi
}


function buildinger() {
    args="${*}"
    $SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh $args
    
    # If a build happended then do post buildinger steps
    if [[ $args != *"--without-build"* ]]; then
        spost_buildinger
        show_notification "Buildinger" "Buildinger done"
    fi
    
}


function _screate_venv() {
    if [[ -z "${SCHRODINGER}" ]]; then
        echo '$SCHRODINGER is not set.'
        return 1
    else
        echo "Creating Schrodinger virtualenv..."
        # $SCHRODINGER is a path like "/scr/$USER/builds/branch-name/build". Extract branch-name from it.
        branch_name=$(echo $SCHRODINGER | awk -F'/' '{print $(NF-1)}')
        srun schrodinger_virtualenv.py ~/.virtualenvs/$branch_name
    fi
}


# Schrodinger Virtualenv (if doesn't exist for $SCHRODINGER then create one)
function svenv() {
    if [[ -z "${SCHRODINGER}" ]]; then
        echo '$SCHRODINGER is not set.'
        return 1
    else
        # $SCHRODINGER is a path like "/scr/$USER/builds/branch-name/build". Extract branch-name from it.
        branch_name=$(echo $SCHRODINGER | awk -F'/' '{print $(NF-1)}')
        if [[ ! -d ~/.virtualenvs/$branch_name ]]; then
            _screate_venv
        fi
        echo "Activating Schrodinger virtualenv..."
        source ~/.virtualenvs/$branch_name/bin/activate
    fi
}


function spycharm() {
    if [[ -z "${SCHRODINGER}" ]]; then
        echo '$SCHRODINGER is not set.'
        return 1
    else
        echo "Starting PyCharm..."
        srun pycharm-community > /dev/null 2>&1 &
    fi
}

stmux() {
    branch=$1
    if [ -z $branch ]; then
        echo "No branch name given"
        return 1
    fi

    if ! tmux has-session -t $branch 2>/dev/null; then
        # Create a new session with src, build and test windows and source the build environment
        local name=${branch:2}
        # src
        tmux new-session -s $branch -n src -d
        tmux send-keys -t $branch:0 "$name && ssch && mm && clear"  C-m
        # build
        tmux new-window -t $branch:1 -n build
        tmux send-keys -t $branch:1 "$name && ssch && mmb && clear"  C-m
        # test
        tmux new-window -t $branch:2 -n test
        tmux send-keys -t $branch:2 "$name && ssch && mmt && clear"  C-m
        # ipython
        tmux new-window -t $branch:3 -n ipython
        tmux send-keys -t $branch:3 "$name && ssch && clear && srun ipython"  C-m

        tmux select-window -t $branch:0
    fi
    tmux attach -t $branch
}

slogs() {
    if [[ -z "${SCHRODINGER}" ]]; then
        echo '$SCHRODINGER is not set.'
        return 1
    fi

    # in the $SCHRODINGER directory, find all *-v*/make*_all.log files and tail all of them
    tail -f $(find $SCHRODINGER -name "make*_all.log");
}