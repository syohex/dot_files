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

;; Theme
(el-get-bundle syohex/emacs-syohex-theme :name syohex-theme
  (add-to-list 'custom-theme-load-path default-directory))

;; Input method
(el-get-bundle elpa:mozc)

;; undo
(el-get-bundle undo-tree :type git :url "http://www.dr-qubit.org/git/undo-tree.git")

;; highlighting
(el-get-bundle vline)
(el-get-bundle col-highlight)

;; Search
(el-get-bundle syohex/emacs-anzu :name anzu)

;; moving cursor
(el-get-bundle goto-chg)
(el-get-bundle abo-abo/avy)

;; Pair
(el-get-bundle capitaomorte/autopair)
(el-get-bundle paredit :type git :url "http://mumble.net/~campbell/git/paredit.git")

;; Region
(el-get-bundle rejeep/wrap-region)

;; Buffer
(el-get-bundle emacs-jp/elscreen)
(el-get-bundle m2ym/popwin-el :name popwin)
(el-get-bundle lukhas/buffer-move)
(el-get-bundle syohex/emacs-import-popwin :name import-popwin)
(el-get-bundle syohex/emacs-zoom-window :name zoom-window)

;; Directory
(el-get-bundle m2ym/direx-el :name direx)
(el-get-bundle syohex/emacs-dired-k :name dired-k)
(el-get-bundle dired-hacks)

;; auto-complete
(el-get-bundle auto-complete/popup-el :name popup)
(el-get-bundle auto-complete/fuzzy-el :name fuzzy)
(el-get-bundle auto-complete/auto-complete)

;; helm
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

;; Perl
(el-get-bundle jrockway/cperl-mode)

;; Python
(el-get-bundle tkf/emacs-python-environment)
(el-get-bundle tkf/emacs-jedi)

;; Ruby
(el-get-bundle ruby-block)
(el-get-bundle ruby-end)
(el-get-bundle inf-ruby)

;; Emacs Lisp
(el-get-bundle purcell/elisp-slime-nav)

;; Clojure
(el-get-bundle clojure-mode)
(el-get-bundle cider)

;; Build tool
(el-get-bundle cmake-mode)

;; Validation
(el-get-bundle flycheck)

;; Markup language
(el-get-bundle markdown-mode :type git :url "git://jblevins.org/git/markdown-mode.git")
(el-get-bundle yoshiki/yaml-mode)

;; HTML
(el-get-bundle fxbois/web-mode)
(el-get-bundle smihica/emmet)

;; shell
(el-get-bundle syohex/emacs-quickrun :name quickrun)
(el-get-bundle syohex/emacs-eshellutil :name eshellutil)

;; VCS
(el-get-bundle magit/magit :branch "next")
(el-get-bundle syohex/emacs-git-gutter :name git-gutter)

;; Documentation
(el-get-bundle zeal-at-point)

;; auto-complete plugins
;;(el-get-bundle qoocku/ac-sly)
(el-get-bundle clojure-emacs/ac-cider)
(el-get-bundle nsf/gocode :load-path ("emacs"))
(el-get-bundle syohex/emacs-ac-ispell :name ac-ispell)
(el-get-bundle syohex/emacs-ac-etags :name ac-etags)
(el-get-bundle dgutov/robe)
(el-get-bundle zk-phi/ac-c-headers)

;; Helm plugins
(el-get-bundle ShingoFukuyama/helm-swoop)
(el-get-bundle emacs-helm/helm-descbinds)
(el-get-bundle syohex/emacs-helm-gtags :name helm-gtags)
(el-get-bundle syohex/emacs-helm-ag :name helm-ag)
(el-get-bundle syohex/emacs-helm-pydoc :name helm-pydoc)
(el-get-bundle syohex/emacs-helm-perldoc :name helm-perldoc)
(el-get-bundle syohex/emacs-helm-open-github :name helm-open-github)
(el-get-bundle syohex/emacs-helm-godoc :name helm-godoc)

;; Evil
(el-get-bundle evil)
