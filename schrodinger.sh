export SCHRODINGER_LIB=/Users/$USER/builds/software/lib
export INTEL_LICENSE_FILE=28518@nyc-lic-intel.schrodinger.com
alias designer='open $QTDIR/bin/Designer.app'

function sdgr() {
    branch=$1;
    export SCHRODINGER_SRC=/Users/$USER/builds/$branch/source;
    export SCHRODINGER=/Users/$USER/builds/$branch/build;
    source $SCHRODINGER_SRC/mmshare/build_env -b;
}
alias 22-2='sdgr 2022-2'

alias mm='cd ${SCHRODINGER_SRC}/mmshare'
alias sdgr_build='cd $SCHRODINGER'
alias mm_build='cd ${SCHRODINGER}/mmshare-v*'
alias mm_test='cd ${SCHRODINGER}/mmshare-v*/python/test'
alias schrun='${SCHRODINGER}/run'
alias buildinger='${SCHRODINGER_SRC}/mmshare/build_tools/buildinger.sh'

alias pytest='${SCHRODINGER}/utilities/py.test'
alias mpytest='make python && pytest'

alias maestro='${SCHRODINGER}/maestro -console'

function mmaestro() {
    orig_pwd=$PWD;
    cd $SCHRODINGER/mmshare-v*;
    make python;
    cd $orig_pwd;
    maestro;
}

function mmv() {
    bld=${1:-master}
    curl -s "https://cgit.schrodinger.com/cgit/mmshare/plain/version.h?h=$bld" | grep "#define MMSHARE_VERSION" | awk '{ printf("%03d\n", $3%1000+1) }'
}

function switch_all_branch() {
    branch=${1:-master}
    for repo in *; do cd $repo && git fetch && git checkout $branch && git pull --rebase && cd ..; done;
    }

alias maelog='less $SCHRODINGER/maestro-v*/make_maestro-src_all.log'
alias mmlog='less $SCHRODINGER/mmshare-v*/make_mmshare_all.log'
