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
  (keymap-global-set "C-c t l" 'todo-highlight-mode-list-todos)
  
  (if todo-highlight-mode
      (todo-highlight-words)
    (remove-overlays)))

(defvar WORD_NOTE	" ?NOTE:.*\\| ?note:.*\\| ?INFO:.*\\| ?info:.*")
(defvar WORD_TODO	" ?TODO:.*\\| ?todo:.*\\| ?TBD:.*\\| ?tbd:.*")
(defvar WORD_WARNING	" ?WARN:.*\\| ?WARNING:.*\\| ?warn:.*\\| ?warning:.*")
(defvar WORD_CAUTION	" ?CAUTION:.*\\| ?caution:.*\\| ?BUG:.*\\| ?bug:.*")
(defvar WORD_FIXME	" ?FIXME:.*\\| ?fixme:.*\\| ?FIX:.*\\| ?fix:.*")

(defun todo-highlight-mode-refresh ()
  (interactive)
  (if todo-highlight-mode (todo-highlight-mode -1))
  (when (not todo-highlight-mode) (todo-highlight-mode 1)))

(defun todo-highlight-words ()
  (highlight-regexp	WORD_TODO	'hi-green)
  (highlight-regexp	WORD_WARNING	'hi-yellow)
  (highlight-regexp	WORD_NOTE	'hi-blue)
  (highlight-regexp	WORD_CAUTION	'hi-salmon)
  (highlight-regexp	WORD_FIXME	'isearch-fail))

(defun todo-highlight-mode-list-todos ()
  (interactive)
  (occur (concat WORD_NOTE WORD_TODO WORD_WARNING WORD_CAUTION WORD_FIXME)))

(define-global-minor-mode global-todo-highlight-mode todo-highlight-mode
  (lambda ()
    (when (derived-mode-p 'prog-mode)
      (todo-highlight-mode-refresh))))
