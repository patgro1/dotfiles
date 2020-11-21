(setq user-full-name "Patrick Grogan"
      user-mail-address "pgrogan@gmail.com")

 (setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16)
        doom-unicode-font (font-spec :name "Noto Color Emoji" :size 20)
        doom-variable-pitch-font (font-spec :family "Helvetica Neue" :size 16))

     (setq-default indent-tabs-mode nil)
     (setq-default tab-width 4)
     (setq-default standard-indent 4)
     (setq-default tab-stop-list (number-sequence 4 120 4))

     (add-hook 'before-save-hook 'delete-trailing-whitespace)

 (setq display-line-numbers-type 'relative)

 (add-hook! prog-mode-hook (modify-syntax-entry ?_ "w"))

 (load-theme 'doom-dark+ t)

  (add-to-list 'auto-mode-alist '("make_\.\*" . makefile-mode))
  (add-to-list 'auto-mode-alist '("Makefile\.\*" . makefile-mode))

 (after! ansi-color
   (defun display-ansi-colors ()
     (interactive)
     (ansi-color-apply-on-region (point-min) (point-max))))

 (after! projectile
   (setenv "WORKON_HOME" "~/virtualenvs")
   (setq projectile-indexing-mode 'alien
         projectile-project-search-path '("~/workspace"))
   (defun setup_env (&optional name)
     (interactive
      (list
       (completing-read "Work on: " (pyvenv-virtualenv-list)
                        nil t nil 'pyenv-workon-history nil nil)))
     (pyvenv-deactivate)
     (setenv "TOOLS_PATH" (concat (projectile-project-root) "/tools"))
     (setenv "PYTHONPATH" (concat (projectile-project-root) ":" (getenv "TOOLS_PATH") "/cocotb:" (getenv "TOOLS_PATH") "/themis_fw:"))
     ;(pyvenv-virtualenv-list)

     (pyvenv-workon name)
     (lsp)
     (setq projectile-tags-command (concat (projectile-project-root)"scripts/etags/verilog_etags " (projectile-project-root) "rtl"))
     (setq projectile-tags-file-name (concat (projectile-project-root) "rtl/TAGS"))
     )
   (add-hook! 'projectile-after-switch-project-hook #'setup_env))

(after! lsp-ui
  lsp-ui-doc-enable t
  lsp-ui-doc-mode t)
(map! :leader
      :after lsp-ui
      :desc "Jump backward"
      "c ," #'lsp-ui-peek-jump-backward)
(map! :leader
      :after lsp-ui
      :desc "Jump backward"
      "c ." #'lsp-ui-peek-jump-forward)

 (after! flycheck
   ;(flycheck-add-next-checker 'python-pylint 'python-flake8)
   (add-hook! 'flycheck-mode-hook
     (defun set-python-flycheck ()
       (when (eq major-mode 'python-mode)
         (setq flycheck-checker 'python-flake8)))))
         ;; This will re-enable pylint
         ;(flycheck-disable-checker 'python-pylint t)

  (use-package! company-jedi
    :config
    (add-to-list 'company-backends 'company-jedi)
    (setq jedi:complete-on-dot t)
    :hook
    (inferior-python-mode . jedi:setup)
    (python-mode . jedi:setup))

  (after! jinja2-mode
   (add-to-list 'auto-mode-alist '("\\.jinja2?\\'" . jinja2-mode))
   )

  (after! verilog-mode
    (setq verilog-auto-newline nil
          verilog-tab-auto-indent nil
          verilog-case-indent 4
          verilog-cexp-indent 4
          verilog-highlight-grouping-keyword t
          verilog-highlight-modules nil
          verilog-indent-level 4
          verilog-indent-level-behavioral 4
          verilog-indent-level-declaration 4
          verilog-indent-level-module 4
          verilog-auto-lineup 'assignment)
    (define-key verilog-mode-map (kbd ";") 'self-insert-command)
    (define-key verilog-mode-map (kbd ":") 'self-insert-command)
    (define-key verilog-mode-map (kbd "RET") 'evil-ret)
    (define-key verilog-mode-map (kbd "TAB") 'tab-to-tab-stop)
    ; Load verilog mode only when needed
    (autoload 'verilog-mode "verilog-mode" "Verilog mode" t)
    ; Any files that ends in .v, .dv or .sv should be in verilog mode
    (add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))
    ; Any files in verilog mode should have their keywords colorized
    (add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1))))

  (after! vue-mode
    (add-hook 'vue-mode-hook #'lsp))

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("○" "☉" "◎" "◉" "○" "◌" "◎" "●" "◦" "◯")))

(add-hook 'text-mode-hook 'mixed-pitch-mode)
(defun nolinum ()
  (interactive)
  (setq doom--line-number-style nil)
  (setq display-line-numbers nil)
)
(add-hook 'org-mode-hook 'nolinum)
(after! org
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch))
