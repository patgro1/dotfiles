function fish_prompt
    set -l last_status $transient_status
    set -l prompt_color (set_color green)
    if test $last_status -ne 0
        set prompt_color (set_color red)
    end
    echo (set_color normal)$PWD
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
