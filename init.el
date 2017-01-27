;; General configuration
(setq inhibit-startup-message t)

;; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://melpa.org/packages/") t)

(setq my-packages '(markdown-mode protobuf-mode
				  better-defaults magit ido-ubiquitous
				  yasnippet haskell-mode ghc smex
				  exec-path-from-shell rust-mode toml-mode
				  fzf hindent))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Environment
(defvar user-home (getenv "HOME"))

(exec-path-from-shell-copy-env "PATH")
(when (equal system-type 'darwin)
  (set-frame-font "Menlo-11.0"))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq mac-command-modifier 'meta)
(setq visible-bell nil)
(global-set-key "\M-g" 'goto-line)
(setq column-number-mode t)

(setq scroll-step 1) ;; keyboard scroll one line at a time

(add-to-list 'auto-mode-alist '("\\.ll$" . llvm-mode))

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(progn
  (setq lib-dir (concat user-emacs-directory "lib"))
  (when (file-exists-p lib-dir)
    (mapc 'load (directory-files lib-dir t "^[^#].*el$"))))

(require 'cmm-mode)
(require 'yasnippet)
;; Tell yasnippet where it can find the Haskell snippets
(setq yas-snippet-dirs '("~/.emacs.d/mysnippets"))
(yas-global-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'fzf)
(global-set-key (kbd "C-c f") 'fzf)
