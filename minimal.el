;; Requires
(require 'ido)
(require 'org-tempo)
(require 'package)
(require 'use-package)

;; Modes
(icomplete-mode)
(ido-mode t)
(ido-everywhere t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(which-key-mode t)
(delete-selection-mode t)
(global-auto-revert-mode t)
(global-prettify-symbols-mode)
(global-hl-line-mode t)

;; Variables
(setq backup-directory-alist '(("." . "~/.local/share/backups"))
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      tooltip-use-echo-area t
      global-auto-revert-non-file-buffers t
      use-dialog-box nil
      custom-file "~/.custom.el"
      use-package-always-ensure t
      warning-minimum-level
      :emergency)

(setq-default org-edit-src-content-indentation 0
	      org-support-shift-select t
	      org-startup-indented t
	      org-pretty-entities t
	      org-use-sub-superscripts "{}"
	      org-hide-emphasis-markers t
	      org-startup-with-inline-images t
	      org-image-actual-width '(300))

;; Lists
(add-to-list 'default-frame-alist '(font . "Iosevka-10"))

;; Use-package
(package-initialize)

;; Packages
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; Hooks
(add-hook 'prog-mode-hook
	  (lambda ()
	    (display-line-numbers-mode t)))

;; Keybindings
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-<tab> e") 'eshell)
(global-set-key (kbd "C-<tab> c") 'compile)
(global-set-key (kbd "C-<tab> .") 'ffap)
(global-set-key (kbd "C-<tab> r") 'restart-emacs)
(global-set-key (kbd "C-<tab> m") 'modus-themes-toggle)
(global-set-key (kbd "C-<tab> <left>") 'windmove-left)
(global-set-key (kbd "C-<tab> <right>") 'windmove-right)
(global-set-key (kbd "C-<tab> <up>") 'windmove-up)
(global-set-key (kbd "C-<tab> <down>") 'windmove-down)
