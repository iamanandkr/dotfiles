if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
export JAVA_HOME='/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home'
export JAVA_HOME_COMPILE=$JAVA_HOME
export JAVA=$JAVA_HOME/bin/java

export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
export SEURAT_SRC="/Users/$USER/code/seurat/" 

[ -f ~/tmux_core_suite.sh ] && source ~/tmux_core_suite.sh
