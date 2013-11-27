
export PATH=/c/MinGW/bin:$PATH

alias vi='/c/Program\ Files\ \(x86\)/Vim/vim74/gvim.exe'

winpath() {
    if [ -z "$1" ]; then
        echo "$@"
    else
        if [ -f "$1" ]; then
            local dir=$(dirname "$1")
            local fn=$(basename "$1")
            echo "$(cd "$dir"; echo "$(pwd -W)/$fn")" | sed 's|/|\\|g';
        else
            if [ -d "$1" ]; then
                echo "$(cd "$1"; pwd -W)" | sed 's|/|\\|g';
            else
                echo "$1" | sed 's|^/\(.\)/|\1:\\|g; s|/|\\|g';
            fi
        fi
    fi
}
