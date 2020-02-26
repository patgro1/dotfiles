(setq user-full-name "Patrick Grogan"
      user-mail-address "pgrogan@gmail.com")

(setq doom-font (font-spec :family "Fira Code" :size 16))

(setq doom-unicode-font (font-spec :name "DejaVu Sans Mono" :size 20))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq-default tab-stop-list (number-sequence 4 120 4))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq display-line-numbers-type 'relative)

(after! ansi-color
  (defun display-ansi-colors ()
    (interactive)
    (ansi-color-apply-on-region (point-min) (point-max))))

(after! projectile
  (setq projectile-indexing-mode 'alien
        projectile-project-search-path '("~/workspace"))
  (defun setup_env ()
    (interactive )
    (pyvenv-mode t)
    (setenv "TOOLS_PATH" (concat (projectile-project-root) "/tools"))
    (setenv "PYTHONPATH" (concat (projectile-project-root) ":" (getenv "TOOLS_PATH") "/cocotb:" (getenv "TOOLS_PATH") "/themis_fw:"))
    (message (concat "working on" (projectile-project-root) "/virtualenvs"))
    (setenv "WORKON_HOME" (concat (projectile-project-root) "virtualenvs"))
    (pyvenv-workon (car (pyvenv-virtualenv-list)))
    (lsp))
    (setq projectile-tags-command (concat (projectile-project-root)"scripts/etags/verilog_etags " (projectile-project-root) "rtl"))
    (setq projectile-tags-file-name (concat (projectile-project-root) "rtl/TAGS"))
  (add-hook! 'projectile-after-switch-project-hook #'setup_env))

(setq-hook! 'lsp-ui-mode-hook
  lsp-ui-doc-enable t)

(after! flycheck
  (flycheck-add-next-checker 'python-pylint 'python-flake8)
  (add-hook! 'flycheck-mode-hook
    (defun set-python-flycheck ()
      (when (eq major-mode 'python-mode)
        (setq flycheck-checker 'python-pylint)
        ;; This will re-enable pylint
        (flycheck-disable-checker 'python-pylint t)))))

(use-package! company-jedi
  :config
  (add-to-list 'company-backends 'company-jedi)
  (setq jedi:complete-on-dot t)
  :hook
  (inferior-python-mode . jedi:setup)
  (python-mode . jedi:setup))

(after! verilog-mode
  (setq verilog-auto-newline nil
        verilog-case-indent 4
        verilog-cexp-indent 4
        verilog-highlight-grouping-keyword t
        verilog-highlight-modules nil
        verilog-indent-level 4
        verilog-indent-level-behavioral 4
        verilog-indent-level-declaration 4
        verilog-indent-level-module 4
        verilog-auto-lineup 'assignment)
  ; Load verilog mode only when needed
  (autoload 'verilog-mode "verilog-mode" "Verilog mode" t)
  ; Any files that ends in .v, .dv or .sv should be in verilog mode
  (add-to-list 'auto-mode-alist '("\\.[ds]?vh?\\'" . verilog-mode))
  ; Any files in verilog mode should have their keywords colorized
  (add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1))))

(after! vue-mode
  (add-hook 'vue-mode-hook #'lsp))
