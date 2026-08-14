function refresh_x11 --description 'Update X11 display from tmux (Smart Local & SSH)'
    # 1. On extrait la ligne brute de tmux
    set -l raw_display (tmux show-environment -s | grep "^DISPLAY=")
    if test -z "$raw_display"
        set raw_display (tmux show-environment | grep "^DISPLAY=")
    end

    # Extraction chirurgicale : on ne garde QUE le format ":0", "localhost:10.0", etc.
    # On cherche tout ce qui vient après "DISPLAY=" ou "set -gx DISPLAY " et on extrait proprement la valeur
    set -l tmux_display (echo $raw_display | string match -r 'DISPLAY=["\']?([a-zA-Z0-9:.]+)["\']?' | tail -n 1)

    # 2. ANALYSE DU TYPE DE SESSION
    if string match -q "*localhost*" "$tmux_display"
        # --- MODE SSH ---
        set -gx DISPLAY $tmux_display
        echo "✅ DISPLAY SSH synchronisé : $DISPLAY"
    else
        # --- MODE LOCAL ---
        # On nettoie aussi le DISPLAY du shell actuel de la même façon
        set -l clean_env_display (echo $DISPLAY | string match -r '([a-zA-Z0-9:.]+)' | tail -n 1)
        
        if test -n "$tmux_display"
            set -gx DISPLAY $tmux_display
            echo "🏠 DISPLAY Local synchronisé depuis tmux : $DISPLAY"
        else if test -n "$clean_env_display"
            set -gx DISPLAY $clean_env_display
            echo "🏠 DISPLAY Local conservé et nettoyé : $DISPLAY"
        else
            set -gx DISPLAY :0
            echo "🏠 Aucun DISPLAY local trouvé. Defaulting to : $DISPLAY"
        end
    end

    # 3. Gestion de XAUTHORITY (Nettoyage identique)
    set -l raw_xauth (tmux show-environment -s | grep "^XAUTHORITY=")
    set -l tmux_xauth (echo $raw_xauth | string match -r 'XAUTHORITY=["\']?([a-zA-Z0-9:/._-]+)' | tail -n 1)

    if test -n "$tmux_xauth"
        set -gx XAUTHORITY $tmux_xauth
        echo "🔑 XAUTHORITY synchronisé : $XAUTHORITY"
    else
        set -gx XAUTHORITY $HOME/.Xauthority
        echo "ℹ️  XAUTHORITY standardisé sur ~/.Xauthority"
    end
end
