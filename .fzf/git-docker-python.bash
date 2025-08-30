_fzf_complete_git() {
    ARGS="$@"
    local branches=$(git for-each-ref --format='%(refname:short)' --sort=-committerdate refs/ 2>/dev/null)
    local stashes=$(git stash list | awk -F ': ' '{ print $1 }' 2>/dev/null)
    local file_changes=$(git diff --name-only 2>/dev/null)
    local tags=$(git tag -l --sort=-creatordate 2>/dev/null)
    if [[ $ARGS == *'stash'* ]]; then
        _fzf_complete --preview "git stash show --color=always -p {}" -- "$@" < <(
            echo $stashes
        )
    elif [[ $ARGS == *'restore'* ]]; then
        _fzf_complete --preview "git diff --color=always {}" -- "$@" < <(
            echo $file_changes
        )
    elif [[ $ARGS == *'tag'* ]]; then
        _fzf_complete --preview "git tag -l -n999 --format='%(tag) %(subject) %(body)' {}" -- "$@" < <(
            echo $tags
        )
    else
        _fzf_complete --preview "git log --color=always {}" -- "$@" < <(
            echo $branches
        )
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

_fzf_complete_g() {
    _fzf_complete_git "$@"
}

_fzf_complete_g_post() {
    awk '{print $1}'
}

_fzf_complete_gd() {
    local branches=$(git for-each-ref --format='%(refname:short)' --sort=-committerdate refs/ 2>/dev/null)
    _fzf_complete --preview "git log --color=always {}" -- "$@" < <(
            echo $branches
    )
}

_fzf_complete_gd_post() {
    awk '{print $1}'
}

_fzf_complete_docker() {
    ARGS="$@"
    local images=$(docker images -a --format '{{.Repository}}:{{.Tag}}')
    local containers=$(docker ps -a --format '{{.Names}}')
    if [[ $ARGS == *'run'* ]]; then
        _fzf_complete --preview "docker image history {}" -- "$@" < <(
            echo $images
        )
    elif [[ $ARGS == *'rmi'* ]]; then
        _fzf_complete --preview "docker image history {}" -- "$@" < <(
            echo $images
        )
    elif [[ $ARGS == *'push'* ]]; then
        _fzf_complete --preview "docker image history {}" -- "$@" < <(
            echo $images
        )
    elif [[ $ARGS == *'pull'* ]]; then
        _fzf_complete --preview "docker image history {}" -- "$@" < <(
            echo $images
        )
    elif [[ $ARGS == *'exec'* ]]; then
        _fzf_complete --preview "docker logs --tail 100 {}" -- "$@" < <(
            echo $containers
        )
    elif [[ $ARGS == *'rm '* ]]; then
        _fzf_complete --preview "docker logs --tail 100 {}" -- "$@" < <(
            echo $containers
        )
    elif [[ $ARGS == *'logs'* ]]; then
        _fzf_complete --preview "docker logs --tail 100 {}" -- "$@" < <(
            echo $containers
        )
    else
    	_fzf_path_completion
    fi
}

_fzf_complete_docker_post() {
    awk '{print $1}'
}

_fzf_complete_python() {
    local py_files=$(rg --files -g '{**/*.py}')
    _fzf_complete -- "$@" < <(
        echo $py_files
    )
}

_fzf_complete_python_post() {
    awk '{print $1}'
}

_fzf_complete_python3() {
    _fzf_complete_python "$@"
}

_fzf_complete_python3_post() {
    awk '{print $1}'
}