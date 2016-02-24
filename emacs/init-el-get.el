(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; setup
(el-get-bundle emacs-jp/init-loader)
(el-get-bundle purcell/exec-path-from-shell)

;; library
(el-get-bundle epc)
(el-get-bundle deferred)

;; Utility
(el-get-bundle syohex/emacs-editutil :name editutil)
(el-get-bundle syohex/emacs-progutil :name progutil)
(el-get-bundle myuhe/quick-preview.el :name quick-preview)

;; Theme
(el-get-bundle syohex/emacs-syohex-theme :name syohex-theme
  (add-to-list 'custom-theme-load-path default-directory))

;; Input method
(when (executable-find "mozc_emacs_helper")
  (el-get-bundle elpa:mozc))

;; undo
(el-get-bundle undo-tree)

;; highlighting
(el-get-bundle vline)
(el-get-bundle col-highlight)

;; Search
(el-get-bundle syohex/emacs-anzu :name anzu)

;; moving cursor
(el-get-bundle goto-chg)

;; Pair
(el-get-bundle paredit)

;; Buffer
(el-get-bundle emacs-jp/elscreen)
(el-get-bundle popwin)
(el-get-bundle lukhas/buffer-move)
(el-get-bundle syohex/emacs-import-popwin :name import-popwin)
(el-get-bundle syohex/emacs-zoom-window :name zoom-window)

;; Directory
(el-get-bundle syohex/emacs-dired-k :name dired-k)

;; auto-complete
(el-get-bundle auto-complete/popup-el :name popup)
;; (el-get-bundle auto-complete/fuzzy-el :name fuzzy)
;; (el-get-bundle auto-complete/auto-complete)

;; company
(el-get-bundle company-mode/company-mode)

;; helm
(el-get-bundle jwiegley/emacs-async :name async)
(el-get-bundle emacs-helm/helm)

;; Repeat utility
(el-get-bundle myuhe/smartrep.el)

;; snippet
(el-get-bundle yasnippet)

;; Ocaml
;;(el-get-bundle tuareg-mode)

;; Haskell
;;(el-get-bundle haskell/haskell-mode)
;;(el-get-bundle ghc-mod)

;; CoffeeScript
(el-get-bundle defunkt/coffee-mode)

;; Go
(el-get-bundle go-mode)
(el-get-bundle syohex/emacs-go-eldoc :name go-eldoc)
(el-get-bundle elpa:golint)
;;(el-get-bundle nsf/gocode :load-path ("emacs") :name go-autocomplete)
(el-get-bundle nsf/gocode :load-path ("emacs-company") :name company-go)

;; Python
(el-get-bundle tkf/emacs-python-environment)
(el-get-bundle tkf/emacs-jedi)
(el-get-bundle syohex/emacs-company-jedi :name company-jedi)

;; Perl
;; (el-get-bundle hinrik/perl6-mode)

;; Ruby
(el-get-bundle ruby-block)
(el-get-bundle ruby-end)
(el-get-bundle inf-ruby)
(el-get-bundle dgutov/robe)

;; Emacs Lisp
(el-get-bundle purcell/elisp-slime-nav)

;; Elixir
(el-get-bundle elixir)
(el-get-bundle tonini/alchemist.el)

;; Clojure
(el-get-bundle clojure-mode)
(el-get-bundle cider)

;; Build tool
(el-get-bundle cmake-mode)

;; Validation
(el-get-bundle flycheck)

;; Markup language
(el-get-bundle markdown-mode)
(el-get-bundle yoshiki/yaml-mode)

;; HTML
(el-get-bundle fxbois/web-mode)
(el-get-bundle smihica/emmet)

;; shell
(el-get-bundle syohex/emacs-quickrun :name quickrun)
(el-get-bundle syohex/emacs-eshellutil :name eshellutil)

;; VCS
(el-get-bundle magit)
(el-get-bundle syohex/emacs-git-gutter :name git-gutter)

;; Documentation
(if (eq system-type 'darwin)
    (el-get-bundle dash-at-point)
  (el-get-bundle zeal-at-point))

;; auto-complete plugins
;;(el-get-bundle qoocku/ac-sly)
;;(el-get-bundle zk-phi/ac-c-headers)
;;(el-get-bundle syohex/emacs-ac-alchemist :name ac-alchemist)

;; Helm plugins
(el-get-bundle emacs-helm/helm-descbinds)
(el-get-bundle syohex/emacs-helm-gtags :name helm-gtags)
(el-get-bundle syohex/emacs-helm-ag :name helm-ag)
(el-get-bundle syohex/emacs-helm-pydoc :name helm-pydoc)
(el-get-bundle syohex/emacs-helm-perldoc :name helm-perldoc)
(el-get-bundle syohex/emacs-helm-godoc :name helm-godoc)
