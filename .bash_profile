if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export SEURAT_SRC="/Users/$USER/LiveDesign/seurat/" 
eval "$(/opt/homebrew/bin/brew shellenv)"
