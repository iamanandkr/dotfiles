# Load platform specific features
[ -f ~/schrodinger_platform.sh ] && source ~/schrodinger_platform.sh


# Release alias
alias 23-2='select-build 2023-2'
alias 23-3='select-build 2023-3'


# Easy navigation for Schrodinger paths
alias src='cd $SCHRODINGER_SRC'
alias mm='cd ${SCHRODINGER_SRC}/mmshare'
alias bld='cd $SCHRODINGER'
alias mmb='cd ${SCHRODINGER}/mmshare-v*/'
alias mmt='cd ${SCHRODINGER}/mmshare-v*/python/test'
alias ss='cd ${SCHRODINGER_SRC}/scisol-src'
alias ssb='cd ${SCHRODINGER}/scisol-v*/'
alias mmss='mmb && make python && ssb && make all'


# Schrodinger command
alias srun='${SCHRODINGER}/run'
alias sjsc='${SCHRODINGER}/jsc'


# Python unit tests
alias spytest='srun py.test'
alias mpytest='make python && spytest'


# Build specific
alias ssch='source $SCHRODINGER_SRC/mmshare/build_env'
alias buildinger='$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh'
alias mps='cd $SCHRODINGER/mmshare-v*/ && make python-scripts && cd -'
alias mpm='cd $SCHRODINGER/mmshare-v*/ && make python-modules && cd -'
alias mmlog='less $SCHRODINGER/mmshare-v*/make_mmshare_all.log'
alias maelog='less $SCHRODINGER/maestro-v*/make_maestro-src_all.log'


# Background builder
alias bg-builder='srun $SCHRODINGER_SRC/mmshare/build_tools/background_builder.py'
alias pyrun='srun $SCHRODINGER_SRC/mmshare/build_tools/background_run.py'
alias autorun='srun $SCHRODINGER_SRC/mmshare/build_tools/autobuild.py'
alias pymaestro='srun $SCHRODINGER_SRC/mmshare/build_tools/background_run.py maestro'


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
        make test TEST_ARGS="$args"
    else
        make test
    fi
}
