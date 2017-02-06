(defvar ruin-mode-hook nil)

(defvar ruin-mode-map
  (let ((map (make-sparse-keymap))) map)
  "Keymap for Ruin major mode")

(defconst ruin-keywords '("fn" "data" "match" "let"))

(defvar ruin-mode-font-lock-keywords
  (list
   `(,(concat "\\<" (regexp-opt ruin-keywords t) "\\>") . font-lock-builtin-face)
   '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "Minimal highlighting expressions for Ruin mode")

(defvar ruin-mode-syntax-table
  (let ((table (make-syntax-table)))

    ;; Strings
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\\ "\\" table)

    ;; Comments
    (modify-syntax-entry ?/  ". 124b" table)
    (modify-syntax-entry ?*  ". 23n"  table)
    (modify-syntax-entry ?\n "> b"    table)
    (modify-syntax-entry ?\^m "> b"   table)

    table))

(define-derived-mode ruin-mode prog-mode "Ruin"
  "Major mode for editing Ruin files."
  :syntax-table ruin-mode-syntax-table

  ;; Comment setup
  (setq-local comment-start "// ")
  (setq-local comment-end "")
  (setq-local comment-start "// ")
  (setq-local comment-start-skip "\\(//+\\|/\\*+\\)\\s *")

  ;; Misc
  (setq-local indent-tabs-mode nil)

  ;; Fonts
  (setq-local font-lock-defaults '((ruin-mode-font-lock-keywords) nil nil)))

(add-to-list 'auto-mode-alist '("\\.rn\\'" . ruin-mode))

(provide 'ruin-mode)
