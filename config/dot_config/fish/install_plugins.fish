set PLUGINS "PatrickF1/fzf.fish" \
            "jethrokuan/z"\
            "jomik/fish-gruvbox"\
            "jorgebucaran/autopair.fish"\
            "patrickf3139/Colored-Man-Pages"\
            "edc/bass" \
            "zzhaolei/transient.fish" \
            "jorgebucaran/nvm.fish"


for plugin in $PLUGINS
    fisher install $plugin
end
