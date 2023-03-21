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

    if test -f $HOME/.cargo/env
        bass source $HOME/.cargo/env
    end

    # Set the color scheme to gruvbox
    #theme_gruvbox dark hard
    source $XDG_CONFIG_HOME/fish/themes/tokyonight-night.fish

    # Commands to run in interactive sessions can go here
    if test -f $XDG_CONFIG_HOME/fish/fish_aliases.fish
        source $XDG_CONFIG_HOME/fish/fish_aliases.fish
    end

end


