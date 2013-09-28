;; starter-kit boilerplate
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(git-commit-mode markdown-mode protobuf-mode starter-kit
                                      yasnippet haskell-mode ghc)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; starter-kit boilerplate ends here

(defvar user-home (getenv "HOME"))

(when (equal system-type 'darwin)
  (set-frame-font "Menlo-11.0")
  (setenv "PATH" (concat user-home "/bin:"
                         user-home "/.cabal/bin:"
                         "/usr/texbin:" (getenv "PATH")))
  (push (concat user-home "/bin") exec-path)
  (push (concat user-home "/Library/Haskell/bin") exec-path)
  (push (concat user-home "/.cabal/bin") exec-path)
  (push "/usr/texbin" exec-path))

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
