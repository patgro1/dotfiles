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

    # Set the color scheme to gruvbox
    #theme_gruvbox dark hard
    source $XDG_CONFIG_HOME/fish/themes/tokyonight-night.fish

    # Commands to run in interactive sessions can go here
    if test -f $XDG_CONFIG_HOME/fish/fish_aliases.fish
        source $XDG_CONFIG_HOME/fish/fish_aliases.fish
    end

    # Start vim mode
    fish_vi_key_bindings
    bind \et "tmux_switch"
    bind -M insert \et "tmux_switch"
    bind -M normal \et "tmux_switch"

end

# opam configuration
source /home/pgrogan/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
