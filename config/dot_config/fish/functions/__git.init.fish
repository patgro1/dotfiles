function __git.init
    function __git.create_abbr -d "Create abbreviation/aliases for git commands"
        set -l name $argv[1]
        set -l args $argv[2..-1]

        abbr -a -g $name $args
    end

    # Commit
    __git.create_abbr gc                git commit -v
    __git.create_abbr gc!               git commit -v --amend
    __git.create_abbr gca               git commit -v -a
    __git.create_abbr gcm               git commit -m 
    __git.create_abbr gcma              git commit -m -a

    # Branch management
    __git.create_abbr gn                git branch -vv
    __git.create_abbr gbd               git branch -d 
    __git.create_abbr gbD               git branch -D
    __git.create_abbr gbl               git branch --list

    # Log and status
    __git.create_abbr gst               git status
    __git.create_abbr gl                git log
    __git.create_abbr gla               git log --all
    __git.create_abbr gldo              git log --decorate --oneline --graph
    __git.create_abbr adog              git log --all --decorate --oneline --graph

    __git.create_abbr gco               --function git_checkout
    __git.create_abbr gcoa              --function git_checkout_from_all
    __git.create_abbr gcob              git checkout -b

    # Git fetch
    __git.create_abbr gf                git fetch
    __git.create_abbr gfa               git fetch --all

    # Pull and push
    __git.create_abbr gp                git pull --autostash
    __git.create_abbr gpr               git pull --autostash --rebase
    __git.create_abbr gP                git push
    __git.create_abbr gP!               git push --force-with-lease
    __git.create_abbr gP!!              git push --force

end

