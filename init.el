;; Lists
(add-to-list 'default-frame-alist '(font . "Iosevka-12"))
(add-to-list 'load-path "~/.config/emacs/pkgs/yasnippet")

;; Requires
(require 'ido)
(require 'org-tempo)
(require 'yasnippet)

;; Modes
(tool-bar-mode			-1)
(menu-bar-mode			-1)
(scroll-bar-mode		-1)
(tooltip-mode			-1)
(icomplete-mode			 t)
(ido-mode			 t)
(ido-everywhere			 t)
(which-key-mode			 t)
(delete-selection-mode		 t)
(global-visual-line-mode	 t)
(global-auto-revert-mode	 t)
(global-prettify-symbols-mode	 t)
(global-hl-line-mode		 t)
(global-completion-preview-mode	 t)
(yas-global-mode		 t)

;; UTF-8 by default
(prefer-coding-system 'utf-8)

;; Variables
(setq backup-directory-alist '(("." . "~/.config/emacs/backups"))
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      tooltip-use-echo-area t
      global-auto-revert-non-file-buffers t
      use-dialog-box nil
      custom-file "~/.config/emacs/custom.el"
      use-package-always-ensure t
      warning-minimum-level :error)

(setq-default minor-mode-alist nil
	      fill-column 80
	      org-edit-src-content-indentation 0
	      org-support-shift-select t
	      org-startup-indented t
	      org-pretty-entities t
	      org-use-sub-superscripts "{}"
	      org-hide-emphasis-markers t
	      org-startup-with-inline-images t
	      org-image-actual-width '(300))

;; Keybindings
(keymap-global-set "C-."		'ffap)
(keymap-global-set "C-;"		'duplicate-line)
(keymap-global-set "C-x C-b"		'ibuffer)
(keymap-global-set "C-<tab> e"		'eshell)
(keymap-global-set "C-<tab> c"		'async-shell-command)
(keymap-global-set "C-<tab> r"		'restart-emacs)
(keymap-global-set "C-<tab> m c"	'compile)
(keymap-global-set "C-<tab> m r"	'recompile)
(keymap-global-set "C-<tab> <left>"	'windmove-left)
(keymap-global-set "C-<tab> <right>"	'windmove-right)
(keymap-global-set "C-<tab> <up>"	'windmove-up)
(keymap-global-set "C-<tab> <down>"	'windmove-down)

;; Packages
(load-file "~/.config/emacs/pkgs/simphare-mode.el")
(load-file "~/.config/emacs/pkgs/simpc-mode.el")
(load-file "~/.config/emacs/pkgs/todo.el")
(load-file "~/.config/emacs/pkgs/gruber-darker-theme.el")
(load-file "~/.config/emacs/pkgs/srcery-theme.el")

;; Theme
(load-theme 'srcery t)

;; Hooks
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'global-todo-highlight-mode)
(add-hook 'c-mode-hook #'simpc-mode)

