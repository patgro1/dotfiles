(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(setq package-enable-at-startup nil)
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
(require 'org)
(org-babel-load-file
 (expand-file-name "conf.org"
                   user-emacs-directory))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (hydra rainbow-delimiters counsel ivy material-theme yaml-mode virtualenvwrapper use-package projectile popwin night-owl-theme multi-term markdown-preview-mode magit lsp-ui lsp-python-ms linum-relative kaolin-themes jinja2-mode highlight-indent-guides gruvbox-theme flycheck-pos-tip evil-lion evil-leader dracula-theme doom-themes company-lsp company-jedi))))
