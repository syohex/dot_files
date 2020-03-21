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
(el-get-bundle syohex/emacs-anzu2 :name anzu2)

;; moving cursor
(el-get-bundle goto-chg)
(el-get-bundle abo-abo/avy)

;; Pair
(el-get-bundle paredit)

;; Buffer
(el-get-bundle emacs-jp/elscreen)
(el-get-bundle popwin)
(el-get-bundle lukhas/buffer-move)

;; Directory
(el-get-bundle syohex/emacs-dired-k2 :name dired-k2)

;; auto-complete
(el-get-bundle auto-complete/popup-el :name popup)

;; company
(el-get-bundle company-mode/company-mode :name company-mode)

;; helm
(el-get-bundle helm)

;; Repeat utility
(el-get-bundle myuhe/smartrep.el :name smartrep)

;; snippet
(el-get-bundle yasnippet)

;; C/C++
(el-get-bundle clang-format
  :type http
  :url "https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/clang-format.el")

;; Go
(el-get-bundle go-mode)
(el-get-bundle syohex/emacs-go-eldoc :name go-eldoc)
(el-get-bundle golint
  :type http
  :url "https://raw.githubusercontent.com/golang/lint/master/misc/emacs/golint.el")
(el-get-bundle go-guru
  :type http
  :url "https://raw.githubusercontent.com/dominikh/go-mode.el/master/go-guru.el")
;;(el-get-bundle nsf/gocode :load-path ("emacs") :name go-autocomplete)
(el-get-bundle nsf/gocode
  :load-path ("emacs-company") :name company-go
  :depends (company-mode))
(el-get-bundle syohex/emacs-go-impl :name go-impl)
(el-get-bundle syohex/emacs-go-add-tags :name go-add-tags)

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

;; Build tool
(el-get-bundle cmake-mode)

;; Validation
(el-get-bundle flycheck)

;; Markup language
(el-get-bundle markdown-mode)
(el-get-bundle yoshiki/yaml-mode)

;; shell
(el-get-bundle syohex/emacs-quickrun2 :name quickrun2)

;; VCS
(el-get-bundle syohex/emacs-git-gutter2 :name git-gutter2)
(el-get-bundle syohex/emacs-git-messenger2 :name git-messenger2)

;; Documentation
(if (eq system-type 'darwin)
    (el-get-bundle dash-at-point)
  (el-get-bundle zeal-at-point))

;; key
(el-get-bundle which-key)

;; Helm plugins
(el-get-bundle emacs-helm/helm-descbinds)
(el-get-bundle syohex/emacs-helm-gtags :name helm-gtags)
(el-get-bundle syohex/emacs-helm-ag2 :name helm-ag2)
;; (el-get-bundle syohex/emacs-helm-pydoc :name helm-pydoc)
;; (el-get-bundle syohex/emacs-helm-perldoc :name helm-perldoc)
(el-get-bundle syohex/emacs-helm-godoc :name helm-godoc)
