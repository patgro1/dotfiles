function fish_prompt
    set -l last_status $transient_status
    set -l prompt_color (set_color green)
    
    echo (set_color cyan)$PWD (fish_git_prompt)
    echo $prompt_color"> "
end

function fish_right_prompt
    set -l last_time_duration $CMD_DURATION
    set -l duration_prompt
    if test $last_time_duration -ge 1000
        set -l last_duration_color (set_color cyan)
        set -l last_duration_sec (math $last_time_duration / 1000)
        echo $last_duration_color$last_duration_sec s
    end
end

function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo "[N] "
        case insert
            set_color --bold green
            echo "[I] "
        case replace replace_one
            set_color --bold yellow
            echo "[X] "
        case visual
            set_color --bold magenta
            echo "[V] "
        case '*'
            set_color --bold red
            echo "[?] "
    end
    set_color normal
end

function _get_git_prompt
    set --local git_branch (_git_branch)
    echo (set_color grey)"($git_branch)"
end

function _git_branch
    command git symbolic-ref --short HEAD 2>/dev/null;
        or command git rev-parse --short HEAD 2>/dev/null
end

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showuntrackedfiles 0

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green
