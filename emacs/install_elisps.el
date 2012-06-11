;; Emacs lisp install file

;; first eval this code block
(add-to-list 'load-path "~/.emacs.d/auto-install")
;; for auto-install
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; anything インタフェース周りの全体的な改善
(auto-install-batch "anything")

;; text-translator 翻訳
(auto-install-batch "text translator")

;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(let ((install-package-list
       '(auto-complete
         ac-slime
         ace-jump-mode
         bm
         coffee-mode flymake-coffee
         col-highlight c-eldoc
         elscreen expand-region
         fuzzy
         gh gist git-commit
         ghc ghci-completion
         gtags
         haml-mode haskell-mode htmlize
         key-chord
         logito
         mark-multiple
         markdown-mode markdown-mode+
         paredit popup popwin pos-tip
         quickrun
         redo+
         ruby-block ruby-compilation ruby-end ruby-interpolation
         ruby-mode ruby-test-mode ruby-tools inf-ruby
         scala-mode scss-mode smartrep
         undo-tree
         vline
         wrap-region yaml-mode yari yascroll yasnipppet)))
  (dolist (pack install-package-list)
    (package-install pack)))
