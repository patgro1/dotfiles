function tmux_sessionizer --description "Tmux session manager"
   if not type -q fzy && not type -q fzf
       echo "Please install fzf or fzy"
   end
   if not type -q fdfind
       echo "Please install fdfind"
   end

   set directories
   for folder in $argv
       if git -C $folder rev-parse 2> /dev/null
           set -a directories $folder
       else
           set -a directories (fdfind -a --type d --maxdepth 1 . $folder)
       end
   end
   set session_wd (printf "%s\n" $directories | fzf)
   if test -z "$session_wd"
       return 0
   end
   set session_name (basename $session_wd)

    # If session does not exists, create it
    if not tmux ls | grep -c -i -e "^$session_name:" 2>&1 >> /dev/null
        tmux new -d -s $session_name -c $session_wd
    end

    if test -n "$TMUX"
        tmux switch-client -t $session_name
    else
        tmux attach -t $session_name
    end
end
