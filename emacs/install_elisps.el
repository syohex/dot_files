;; Emacs lisp install file

(require 'cl)

(when load-file-name
  (setq user-emacs-directory (file-name-nondirectory load-file-name)))

;; first eval this code block
(add-to-list 'load-path (concat user-emacs-directory "elisps"))

;; check commands
(dolist (cmd '("emacs" "git" "curl" "cvs"))
  (unless (executable-find cmd)
    (error "Please install %s" cmd)))

;; Emacs package system
(require 'package)
(setq package-user-dir (concat user-emacs-directory "elpa"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(package-refresh-contents)

(defvar my/install-packages
  '(
    ;;;; for auto-complete
    auto-complete fuzzy popup ac-slime pos-tip

    ;;;; highlight
    ace-jump-mode vline col-highlight

    ;;;; editing utilities
    expand-region wrap-region
    undo-tree mark-multiple redo+ smartrep
    yasnipppet goto-chg

    ;;;; buffer utils
    popwin elscreen yascroll

    ;;;; programming
    ;; haskell
    haskell-mode ghc ghci-completion

    ;; flymake
    flycheck

    ;; clojure
    clojure-mode nrepl

    ;; coffee-script
    coffee-mode

    ;; perl
    cperl-mode

    ;; python
    jedi

    ;; ruby
    ruby-block ruby-compilation ruby-end ruby-interpolation
    ruby-mode ruby-test-mode ruby-tools inf-ruby
    yari

    ;; emacs-lisp
    elisp-slime-nav thingopt

    ;; Common Lisp
    slime paredit

    ;; common utility
    quickrun

    ;;;; markup language
    haml-mode sass-mode htmlize
    markdown-mode markdown-mode+
    scss-mode yaml-mode zencoding-mode

    ;; helm
    helm helm-gtags helm-descbinds helm-themes

    ;; git
    magit git-gutter
))

(dolist (pack my/install-packages)
  (unless (package-installed-p pack)
    (package-install pack)))
