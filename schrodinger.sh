export SCHRODINGER_LIB=/Users/anakumar/builds/software/lib
export INTEL_LICENSE_FILE=28518@ns4:28518@ns3

alias designer='open $QTDIR/bin/Designer.app'

function sdgr() {
    branch=$1;
    export SCHRODINGER_SRC=/Users/anakumar/builds/$branch/source;
    export SCHRODINGER=/Users/anakumar/builds/$branch/build;
    source $SCHRODINGER_SRC/mmshare/build_env -b;
}
alias 21-4='sdgr 2021-4'
alias 22-1='sdgr 2022-1'

alias mm='cd ${SCHRODINGER_SRC}/mmshare'
alias sdgr_build='cd $SCHRODINGER'
alias schrun='${SCHRODINGER}/run'
alias buildinger.sh='${SCHRODINGER_SRC}/mmshare/build_tools/buildinger.sh'

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
    for repo in *; do cd $repo && git checkout $branch && git pull --rebase && cd ..; done;
    }
