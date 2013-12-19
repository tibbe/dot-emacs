(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'haskell-style)
(global-set-key (kbd "C-c C-h") 'haskell-hoogle)
(global-set-key (kbd "C-c C-r") 'inferior-haskell-reload-file)

(add-to-list 'completion-ignored-extensions ".hi")
(require 'haskell-style)
(require 'ghc-core)

(eval-after-load "haskell-mode"
    '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

(eval-after-load "haskell-cabal"
    '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

(eval-after-load "haskell-mode"
    '(define-key haskell-mode-map (kbd "C-c C-.") 'haskell-sort-imports))

(defun add-ghc-core-keys ()
  (local-set-key (kbd "C-c c") 'ghc-core-clean-buffer))

;; No such hooks 
(add-hook 'ghc-core-mode-hook 'add-ghc-core-keys)

;; (autoload 'ghc-init "ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

(setq haskell-ghci-program-name "/usr/local/bin/ghci")
