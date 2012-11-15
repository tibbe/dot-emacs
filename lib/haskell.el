(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'haskell-style)
(global-set-key (kbd "C-c C-h") 'haskell-hoogle)
(global-set-key (kbd "C-c C-r") 'inferior-haskell-reload-file)
(add-to-list 'auto-mode-alist '("\\.cpphs$" . haskell-mode))
(add-to-list 'completion-ignored-extensions ".hi")
(require 'haskell-cabal)
(require 'haskell-style)
(require 'ghc-core)

(defun add-ghc-core-keys ()
  (local-set-key (kbd "C-c c") 'ghc-core-clean-buffer))

;; No such hooks 
(add-hook 'ghc-core-mode-hook 'add-ghc-core-keys)

;; (add-to-list 'load-path "~/.cabal/share/ghc-mod-1.10.11")
;; (autoload 'ghc-init "ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
