(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(custom-set-variables
 '(el-get-verbose t))

;; setup
(el-get-bundle emacs-jp/init-loader)
(el-get-bundle purcell/exec-path-from-shell)

;; My Utilities
(el-get-bundle syohex/emacs-editutil :name editutil)
(el-get-bundle syohex/emacs-progutil :name progutil)

;; Theme
(el-get-bundle syohex/emacs-syohex-theme :name syohex-theme
  (add-to-list 'custom-theme-load-path default-directory))

;; Input method
(when (executable-find "mozc_emacs_helper")
  (el-get-bundle mozc
    :type http
    :url "https://raw.githubusercontent.com/google/mozc/master/src/unix/emacs/mozc.el"))

;; undo
(el-get-bundle undo-tree)

;; highlighting
(el-get-bundle vline)
(el-get-bundle col-highlight)

;; Search
(el-get-bundle syohex/emacs-anzu :name anzu)

;; moving cursor
(el-get-bundle goto-chg)
(el-get-bundle abo-abo/avy)

;; Pair
(el-get-bundle paredit)

;; Buffer
(el-get-bundle emacs-jp/elscreen)
(el-get-bundle popwin)
(el-get-bundle lukhas/buffer-move)
(el-get-bundle syohex/emacs-import-popwin :name import-popwin)

;; Directory
(el-get-bundle syohex/emacs-dired-k :name dired-k)

;; auto-complete
(el-get-bundle auto-complete/popup-el :name popup)
;; (el-get-bundle auto-complete/fuzzy-el :name fuzzy)
;; (el-get-bundle auto-complete/auto-complete)

;; company
(el-get-bundle company-mode/company-mode)

;; helm
(el-get-bundle emacs-helm/helm
  :autoloads "helm-autoloads"
  :build (("make"))
  :build/darwin `(("make" ,(format "EMACS_COMMAND=%s" el-get-emacs))))

;; Repeat utility
(el-get-bundle myuhe/smartrep.el)

;; snippet
(el-get-bundle yasnippet)

;; Ocaml
;;(el-get-bundle tuareg-mode)

;; Haskell
;;(el-get-bundle haskell/haskell-mode)
;;(el-get-bundle ghc-mod)

;; Go
(el-get-bundle go-mode)
(el-get-bundle syohex/emacs-go-eldoc :name go-eldoc)
(el-get-bundle golint
  :type http
  :url "https://github.com/golang/lint/blob/master/misc/emacs/golint.el")
(el-get-bundle go-guru
  :type http
  :url "https://raw.githubusercontent.com/dominikh/go-mode.el/master/go-guru.el")
;;(el-get-bundle nsf/gocode :load-path ("emacs") :name go-autocomplete)
(el-get-bundle nsf/gocode :load-path ("emacs-company") :name company-go)
(el-get-bundle syohex/emacs-go-impl :name go-impl)
(el-get-bundle syohex/emacs-go-add-tags :name go-add-tags)

;; Python
(el-get-bundle company-jedi)

;; Perl
;; (el-get-bundle hinrik/perl6-mode)

;; Ruby
(el-get-bundle ruby-block)
(el-get-bundle ruby-end)
(el-get-bundle inf-ruby)
(el-get-bundle dgutov/robe)

;; Emacs Lisp
(el-get-bundle purcell/elisp-slime-nav :name elisp-slime-nav)

;;;; Elixir
;;(el-get-bundle elixir)
;;(el-get-bundle tonini/alchemist.el)

;; Rust
(el-get-bundle rust-mode)
(el-get-bundle racer-rust/emacs-racer
  :name racer
  :depends (rust-mode dash s f))
(el-get-bundle flycheck/flycheck-rust)

;; Clojure
(el-get-bundle clojure-mode)
(el-get-bundle cider)
(el-get-bundle clj-refactor)

;; Javascript
(el-get-bundle tern)
(el-get-bundle company-tern)
(el-get-bundle json-mode)

;; Build tool
(el-get-bundle cmake-mode)

;; Validation
(el-get-bundle flycheck)

;; Markup language
(el-get-bundle markdown-mode)
(el-get-bundle markdown-toc)
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
(el-get-bundle syohex/emacs-git-messenger :name git-messenger)

;; Documentation
(if (eq system-type 'darwin)
    (el-get-bundle dash-at-point)
  (el-get-bundle zeal-at-point))

;; auto-complete plugins
;;(el-get-bundle qoocku/ac-sly)
;;(el-get-bundle zk-phi/ac-c-headers)
;;(el-get-bundle syohex/emacs-ac-alchemist :name ac-alchemist)

;; key
(el-get-bundle which-key)

;; Helm plugins
(el-get-bundle emacs-helm/helm-descbinds)
(el-get-bundle syohex/emacs-helm-gtags :name helm-gtags)
(el-get-bundle syohex/emacs-helm-ag :name helm-ag)
(el-get-bundle syohex/emacs-helm-pydoc :name helm-pydoc)
(el-get-bundle syohex/emacs-helm-perldoc :name helm-perldoc)
(el-get-bundle syohex/emacs-helm-godoc :name helm-godoc)

;; evil
(when (eq system-type 'darwin)
  (el-get-bundle evil))
