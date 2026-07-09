if status is-interactive
    set -Ux PAGER less
    set -Ux EDITOR nvim
    set -Ux VISUAL nvim
    set -U fish_greeting
    # Bootstrapping fisher
    if ! test -f $XDG_CONFIG_HOME/fish/functions/fisher.fish
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        source $XDG_CONFIG_HOME/fish/install_plugins.fish
    end
    set -a PATH $HOME/.local/bin

    if test -f $HOME/.cargo/env
        bass source $HOME/.cargo/env
    end
    if test -e $XDG_CONFIG_HOME/emacs/bin
        set -a PATH $XDG_CONFIG_HOME/emacs/bin
    end
    set -Ux FIRMWARES_API_KEY 32c22d97b46881ab6a0979f910366b4b12c3ee1a
    set -Ux FIRMWARES_API_URL https://firmwares.enyx.fr/
    set -Ux FIRMWARES_API_BACKUP_PATH /media/collabwork/temp/redmine_uploads_failure/

    set -Ux DEFAULT_SIMULATOR riviera_pro

    set -Ux GOOGLE_CLOUD_PROJECT_ID "mindful-braid-484220-f2"
    set -Ux GEMINI_API_KEY AIzaSyDSINaglPTQRp2DXUz-9esT21VXDA7YyD8

    set -Ux nvm_default_version lts
    
    # Set the color scheme to gruvbox
    #theme_gruvbox dark hard
    source $XDG_CONFIG_HOME/fish/themes/tokyonight-night.fish

    # Commands to run in interactive sessions can go here
    if test -f $XDG_CONFIG_HOME/fish/fish_aliases.fish
        source $XDG_CONFIG_HOME/fish/fish_aliases.fish
    end

    # Start vim mode
    fish_vi_key_bindings
    for mode in (bind -L)
        bind -M $mode alt-t "tmux_sessionizer"
        bind -M $mode alt-g "lazygit"
    end

end


# Added by Antigravity CLI installer
set -gx PATH "/home/pgrogan/.local/bin" $PATH
