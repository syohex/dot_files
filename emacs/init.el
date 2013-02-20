;; for lancher
(unless load-file-name
  (cd (getenv "HOME")))

;; Add load path of emacs lisps
(add-to-list 'load-path (concat user-emacs-directory "elisps"))

;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; load environment value
(let ((shellenv (concat user-emacs-directory "shellenv.el")))
  (when (file-exists-p shellenv)
    (load-file shellenv)
    (dolist (path (reverse (split-string (getenv "PATH") ":")))
      (add-to-list 'exec-path path))))

;; setup theme
(load-theme 'reverse t t)
(enable-theme 'reverse)

;; init-loader
(require 'init-loader)
(init-loader-load (concat user-emacs-directory "init_loader"))
