;;; `todo-highlight-mode', um `minor-mode' para colorizar palavras como
;;; `TODO', `WARN', entre outras.
;;;
;;; Author: Tukain <github.com/ventriloquo>
;;
;; warn: eu não sou um programador, por isso o código desse minor-mode é uma bosta.

(define-minor-mode todo-highlight-mode
  "Um modo para destacar palavras como `todo' ou `warning'."
  :lighter " TODO"

  (keymap-global-set "C-c t r"   'todo-highlight-mode-refresh)
  (keymap-global-set "C-c t l t" 'todo-highlight-mode-list-todos)
  (keymap-global-set "C-c t l w" 'todo-highlight-mode-list-warnings)
  (keymap-global-set "C-c t l n" 'todo-highlight-mode-list-notes)
  (keymap-global-set "C-c t l c" 'todo-highlight-mode-list-cautions)
  (keymap-global-set "C-c t l f" 'todo-highlight-mode-list-fixmes)
  
  (if todo-highlight-mode
      (todo-highlight-words)
    (remove-overlays)))

(defvar WORD_TODO	" ?TODO: ?\\| ?todo: ?")
(defvar WORD_WARNING	" ?WARN: ?\\| ?WARNING: ?\\| ?warn: ?\\| ?warning: ?")
(defvar WORD_NOTE	" ?NOTE: ?\\| ?note: ?")
(defvar WORD_CAUTION	" ?CAUTION: ?\\| ?caution: ?")
(defvar WORD_FIXME	" ?FIXME: ?\\| ?fixme: ?\\| ?FIX: ?\\| ?fix: ?")

(defun todo-highlight-mode-refresh ()
  (interactive)
  (if todo-highlight-mode
      (todo-highlight-mode -1))
  (when (not todo-highlight-mode)
    (todo-highlight-mode 1)))

(defun todo-highlight-words ()
  "Colorizando palavras"
  (highlight-regexp WORD_TODO 'hi-green)
  (highlight-regexp WORD_WARNING 'hi-yellow)
  (highlight-regexp WORD_NOTE 'hi-aquamarine)
  (highlight-regexp WORD_CAUTION 'hi-salmon)
  (highlight-regexp WORD_FIXME 'isearch-fail))

(defun todo-highlight-mode-helper (WORD COLOR)
  (occur (format "%s" WORD))
  (highlight-regexp WORD COLOR))

(defun todo-highlight-mode-list-todos ()
  (interactive)
  (todo-highlight-mode-helper WORD_TODO 'hi-green))

(defun todo-highlight-mode-list-warnings ()
  (interactive)
  (todo-highlight-mode-helper WORD_WARNING 'hi-yellow))

(defun todo-highlight-mode-list-notes ()
  (interactive)
  (todo-highlight-mode-helper WORD_NOTE 'hi-aquamarine))

(defun todo-highlight-mode-list-cautions ()
  (interactive)
  (todo-highlight-mode-helper WORD_CAUTION 'hi-salmon))

(defun todo-highlight-mode-list-fixmes ()
  (interactive)
  (todo-highlight-mode-helper WORD_FIXME 'isearch-fail))

(define-global-minor-mode global-todo-highlight-mode todo-highlight-mode
  (lambda ()
    (when (derived-mode-p 'prog-mode)
      (todo-highlight-mode-refresh))))
