(require 'haskell-mode)
(require 'haskell-compile)
(require 'haskell-style)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(require 'haskell-hoogle)
(require 'hindent)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; interactive-haskell-mode
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t)
  '(haskell-process-type 'stack-ghci)
  '(haskell-compile-cabal-build-command "stack build")
  '(setq hindent-style "johan-tibell"))

;; Most key bindings are set by interactive-haskell-mode
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))

(add-hook 'haskell-mode-hook 'haskell-style)
(global-set-key (kbd "C-c C-h") 'haskell-hoogle)

(add-to-list 'completion-ignored-extensions ".hi")
(require 'ghc-core)

(add-to-list 'auto-mode-alist '("\\.dump-simpl\\'" . ghc-core-mode))

(defun set-ghc-compile-command ()
  "Setup haskell-compile-cabal-build-command for GHC development."
  (interactive)
  (set-variable 'haskell-compile-cabal-build-command
                "cd ~/src/ghc; make -C compiler 2 EXTRA_HC_OPTS=-ferror-spans"))
