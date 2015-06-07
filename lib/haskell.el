(require 'haskell-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; interactive-haskell-mode
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))

(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

(define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)

(setq haskell-process-type 'cabal-repl)
;; end interactive-haskell-mode

(add-hook 'haskell-mode-hook 'haskell-style)
(global-set-key (kbd "C-c C-h") 'haskell-hoogle)

(add-to-list 'completion-ignored-extensions ".hi")
;; (require 'haskell-style)
(require 'ghc-core)

(add-to-list 'auto-mode-alist '("\\.dump-simpl\\'" . ghc-core-mode))

(defun set-ghc-compile-command ()
  "Setup haskell-compile-cabal-build-command for GHC development."
  (interactive)
  (set-variable 'haskell-compile-cabal-build-command
                "cd ~/src/ghc; make -C compiler 2 EXTRA_HC_OPTS=-ferror-spans"))
