;; Requires
(require 'ido)
(require 'org-tempo)
(require 'ansi-color)

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
(global-visual-line-mode t)
(global-auto-revert-mode t)
(global-prettify-symbols-mode)
(global-hl-line-mode t)
(global-completion-preview-mode t)

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

;; Lists
(add-to-list 'default-frame-alist '(font . "Iosevka-12"))

;; Packages
(load-file "~/.config/emacs/pkgs/gruber-darker-theme.el")
(load-file "~/.config/emacs/pkgs/hare-mode.el")

;; Theme
(load-theme 'gruber-darker t)

;; Hooks
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'org-mode-hook #'visual-fill-column-mode)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; Keybindings
(keymap-global-set "C-x C-b"		'ibuffer)
(keymap-global-set "C-."		'ffap)
(keymap-global-set "C-;"		'duplicate-line)
(keymap-global-set "C-<tab> a"		'align-regexp)
(keymap-global-set "C-<tab> e"		'eshell)
(keymap-global-set "C-<tab> c"		'async-shell-command)
(keymap-global-set "C-<tab> m c"	'compile)
(keymap-global-set "C-<tab> m r"	'recompile)
(keymap-global-set "C-<tab> r"		'restart-emacs)
(keymap-global-set "C-<tab> <left>"	'windmove-left)
(keymap-global-set "C-<tab> <right>"	'windmove-right)
(keymap-global-set "C-<tab> <up>"	'windmove-up)
(keymap-global-set "C-<tab> <down>"	'windmove-down)

;; rmail
(setq smtpmail-default-smtp-server "mail.cock.li")
(require 'smtpmail)
(setq rmail-inbox-list '("imaps://diogo%40cock.li:zJg0z%9q8t6.UPQX;U)9&#zXfKHYph$Ghna6E^P2$b!:[5c]ChV[7+1!Tdd7NP..@mail.cock.li")
      read-mail-command	           'rmail
      mail-user-agent	           'sendmail-user-agent
      rmail-preserve-inbox         nil
      rmail-mime-prefer-html       t
      rmail-file-name              "~/.local/mail/inbox"
      message-default-headers      "Fcc: ~/.local/mail/sent"
      user-full-name               "Diogo"
      user-mail-address            "diogo@cock.li"
      shr-width                    80
      send-mail-function           'smtpmail-send-it
      smtpmail-stream-type         'ssl
      smtpmail-smtp-service        465)
