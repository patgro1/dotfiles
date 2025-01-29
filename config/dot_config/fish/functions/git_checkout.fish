function git_checkout_from_all
    git_checkout --all
end

function git_checkout -d "Checkout a branch. 
                          If all is passed will it will show all available branhces.
                          Else it will only show local branches"
    argparse a/all -- $argv
    set -l branch
    if set -q _flag_all
        set -l selected_branch  (git branch -a | fzf | string trim -l)
        set branch (string match -gr "(?:remotes\/.*?\/)?(.*)" $selected_branch)
    else
        set branch $(git branch | fzf)
    end
    if test -z $branch
        ""
    else
        echo "git checkout $branch"
    end

end

