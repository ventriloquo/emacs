(require 'subr-x)

(defvar simphare-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; C/C++ style comments
	(modify-syntax-entry ?/ ". 124b" table)
  	(modify-syntax-entry ?\n "> b" table)
    ;; Chars are the same as strings
    (modify-syntax-entry ?' "\"" table)
    table))

(defun simphare-find-branches ()
  (interactive)
  (occur "if.*\\|else.*\\|.*||.*\\|switch.*\\|match.*\\|case.*"))

(defun simphare-find-blocks ()
  (interactive)
  (occur ".*(.*).*{"))

(defun simphare-types ()
  '("u8" "u16" "u32" "u64" "i8" "i16" "i32" "i64" "int" "uint"
    "uintptr" "f32" "f64" "bool" "char" "str" "void" "struct" "union"
    "nullable" "null" "valist" "rune" "enum" "opaque"))

(defun simphare-keywords ()
  '("as" "break" "const" "continue" "def" "else" "export" "fn" "for"
    "if" "is" "let" "match" "return" "size" "static" "switch" "use"
    "_" "defer" "yield" "case" "type" "assert" "len"))

(defun simphare-constants ()
  '("true" "false"))

(defun simphare-attributes ()
  '("@test" "@init" "@fini"))

(defun simphare-font-lock-keywords ()
  (list
   `("@ *[@a-zA-Z0-9_]+" . font-lock-preprocessor-face)
   `(,(regexp-opt (simphare-constants) 'symbols) . font-lock-warning-face)
   `(,(regexp-opt (simphare-keywords) 'symbols) . font-lock-keyword-face)
   `(,(regexp-opt (simphare-attributes) 'symbols) . font-lock-preprocessor-face)
   `(,(regexp-opt (simphare-types) 'symbols) . font-lock-type-face)))


(defun simphare--previous-non-empty-line ()
  (save-excursion
    (forward-line -1)
    (while (and (not (bobp))
                (string-empty-p
                 (string-trim-right
                  (thing-at-point 'line t))))
      (forward-line -1))
    (thing-at-point 'line t)))

(defun simphare--indentation-of-previous-non-empty-line ()
  (save-excursion
    (forward-line -1)
    (while (and (not (bobp))
                (string-empty-p
                 (string-trim-right
                  (thing-at-point 'line t))))
      (forward-line -1))
    (current-indentation)))

(defun simphare--desired-indentation ()
  (let* ((cur-line (string-trim-right (thing-at-point 'line t)))
         (prev-line (string-trim-right (simphare--previous-non-empty-line)))
         (indent-len 8)
         (prev-indent (simphare--indentation-of-previous-non-empty-line)))
    (cond
     ((string-match-p "^\\s-*switch\\s-*(.+)" prev-line)
      prev-indent)
     ((and (string-suffix-p "{" prev-line)
           (string-prefix-p "}" (string-trim-left cur-line)))
      prev-indent)
     ((string-suffix-p "{" prev-line)
      (+ prev-indent indent-len))
     ((string-prefix-p "}" (string-trim-left cur-line))
      (max (- prev-indent indent-len) 0))
     ((string-suffix-p ":" prev-line)
      (if (string-suffix-p ":" cur-line)
          prev-indent
        (+ prev-indent indent-len)))
     ((string-suffix-p ":" cur-line)
      (max (- prev-indent indent-len) 0))
     (t prev-indent))))

;;; TODO: customizable indentation (amount of spaces, tabs, etc)
(defun simphare-indent-line ()
  (interactive)
  (when (not (bobp))
    (let* ((desired-indentation
            (simphare--desired-indentation))
           (n (max (- (current-column) (current-indentation)) 0)))
      (indent-line-to desired-indentation)
      (forward-char n))))

(define-derived-mode simphare-mode prog-mode "Simple Hare"
  "Simple major mode for editing Hare files. (Based on simpc-mode, from Rexim)"
  :syntax-table simphare-mode-syntax-table
  (setq-local font-lock-defaults '(simphare-font-lock-keywords))
  (setq-local indent-line-function 'simphare-indent-line)
  (setq-local comment-start "// "))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ha\\'" . simphare-mode))

(provide 'simphare-mode)
