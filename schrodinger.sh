export SCHRODINGER_LIB=/Users/anakumar/builds/software/lib
export INTEL_LICENSE_FILE=28518@ns4:28518@ns3

function sdgr() {
    branch=$1;
    export SCHRODINGER_SRC=/Users/anakumar/builds/$branch/source;
    export SCHRODINGER=/Users/anakumar/builds/$branch/build;
    $SCHRODINGER_SRC/mmshare/build_env -b;
}

alias mm='cd ${SCHRODINGER_SRC}/mmshare'
alias sdgr_build='cd $SCHRODINGER'
alias schrun='${SCHRODINGER}/run'
alias buildinger.sh='${SCHRODINGER_SRC}/mmshare/build_tools/buildinger.sh'

alias pytest='${SCHRODINGER}/utilities/py.test -n=4'
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
