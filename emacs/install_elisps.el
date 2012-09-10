;; Emacs lisp install file

;; first eval this code block
(add-to-list 'load-path "~/.emacs.d/auto-install")

;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defvar my/install-packages
  '(
    ;;;; for auto-complete
    auto-complete fuzzy popup ac-slime pos-tip

    ;;;; highlight
    ace-jump-mode bm vline col-highlight

    ;;;; git
    gh gist git-commit

    ;;;; editing utilities
    expand-region key-chord wrap-region
    undo-tree mark-multiple redo+ smartrep
    yasnipppet

    ;;;; buffer utils
    popwin elscreen yascroll

    ;;;; programming
    ;; haskell
    haskell-mode ghc ghci-completion

    ;; coffee-script
    coffee-mode flymake-coffee

    ;; ruby
    ruby-block ruby-compilation ruby-end ruby-interpolation
    ruby-mode ruby-test-mode ruby-tools inf-ruby
    yari

    ;; Common Lisp
    paredit

    ;; scala
    scala-mode

    ;; common utility
    quickrun

    ;;;; markup language
    haml-mode htmlize
    markdown-mode markdown-mode+
    scss-mode yaml-mode

    ;; helm
    helm helm-gtags

    ;;;; misc
    logito
))

(dolist (pack my/install-packages)
  (package-install pack))
