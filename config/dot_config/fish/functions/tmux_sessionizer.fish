function tmux_sessionizer --description "Tmux session manager"
    set -l folders $(string split ' ' (_get_tmux_folders))
    set -l selected_project_dir $(printf "%s\n" $folders | fzf --border=sharp)

    if test -z $selected_project_dir
        return
    end

    # Replace ~ by /home/$USER
    set selected_project_dir (string replace "~" "/home/$USER" $selected_project_dir)

    # Extract the basename of the directory for tmux session
    set -l tmux_session_name $(basename $selected_project_dir)

    # Create a new session silently if needed
    if not tmux list-sessions -F '#{session_name}' 2>/dev/null | grep -qx $tmux_session_name
        tmux new-session -d -c $selected_project_dir -s $tmux_session_name
    end

    # If we are in a tmux session, switch to the other session
    if not test -z $TMUX
        tmux switch-client -t $tmux_session_name
    # Else attach to the session
    else
        tmux attach-session -t $tmux_session_name
    end
end

function _get_tmux_folders --description "Create a list of folders to pass to fzf"
    set -l folders_list "~/dotfiles/"
    set -a folders_list "~/dotfiles/config/dot_config/nvim"
    set -a folders_list $(fd --type d --max-depth 1 . ~/workspace)
    echo $folders_list
end
