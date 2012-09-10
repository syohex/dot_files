(cd (getenv "HOME"))

;; Add load path of emacs lisps
(add-to-list 'load-path "~/.emacs.d/elisps")

;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

;; init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/init_loader")
