set PLUGINS "PatrickF1/fzf.fish" \
            "jethrokuan/z"\
            "jomik/fish-gruvbox"\
            "IlanCosman/tide@v5"\
            "jorgebucaran/autopair.fish"\
            "patrickf3139/Colored-Man-Pages"


for plugin in $PLUGINS
    fisher install $plugin
end
