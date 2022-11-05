;; for lancher (package-initialize)
(unless load-file-name
  (cd (getenv "HOME")))

(when load-file-name
  (setq-default user-emacs-directory (file-name-directory load-file-name)))

(custom-set-variables
 '(el-get-verbose t)
 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
 '(backup-directory-alist `((".*" . ,temporary-file-directory)))
 '(comment-style 'extra-line)
 '(create-lockfiles nil)
 '(delete-auto-save-files t)
 '(find-file-visit-truename t)
 '(imenu-auto-rescan t)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold (* 25 1024 1024))
 '(package-enable-at-startup nil)
 '(read-file-name-completion-ignore-case t)
 '(set-mark-command-repeat-pop t)
 '(text-quoting-style 'grave)
 '(user-full-name "Shohei YOSHIDA")
 '(custom-file (concat user-emacs-directory "custom.el"))
 '(flyspell-issue-welcome-flag nil)
 '(flyspell-use-meta-tab nil)
 '(show-paren-delay 0)
 '(show-paren-style 'expression)
 '(parens-require-spaces nil)
 '(view-read-only t)
 '(ls-lisp-dirs-first t)
 '(dired-dwim-target t)
 '(dired-auto-revert-buffer t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always))

(require 'cl-lib)

;; el-get
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

;; My Utilities
(el-get-bundle syohex/emacs-editutil :name editutil)
(el-get-bundle syohex/emacs-zoom-window2 :name zoom-window2)

;; Theme
(el-get-bundle syohex/emacs-syohex-theme :name syohex-theme
               (add-to-list 'custom-theme-load-path default-directory))

;; Input method
(when (executable-find "mozc_emacs_helper")
  (el-get-bundle mozc
                 :type http
                 :url "https://raw.githubusercontent.com/google/mozc/master/src/unix/emacs/mozc.el"))

;; highlighting
(el-get-bundle vline)
(el-get-bundle col-highlight)

;; Search
(el-get-bundle syohex/emacs-anzu2 :name anzu2)

;; moving cursor
(el-get-bundle goto-chg)

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

;; C/C++
(el-get-bundle emacsmirror/clang-format)

;; Go
(el-get-bundle go-mode)

;; Emacs Lisp
(el-get-bundle purcell/elisp-slime-nav)

;; Build tool
(el-get-bundle cmake-mode)

;; Markup language
(el-get-bundle markdown-mode)
(el-get-bundle yoshiki/yaml-mode)

;; shell
(el-get-bundle syohex/emacs-quickrun2 :name quickrun2)

;; VCS
(el-get-bundle syohex/emacs-git-gutter2 :name git-gutter2)
(el-get-bundle syohex/emacs-git-messenger2 :name git-messenger2)

;; key
(el-get-bundle which-key)

;; Helm plugins
(el-get-bundle emacs-helm/helm-descbinds)
(el-get-bundle syohex/emacs-helm-gtags2 :name helm-gtags2)
(el-get-bundle syohex/emacs-helm-ag2 :name helm-ag2)

(custom-set-variables
 '(exec-path-from-shell-check-startup-files nil))
(exec-path-from-shell-copy-envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH"))

;;;; setup theme
(load-theme 'syohex t t)
(enable-theme 'syohex)

;; basic
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(global-font-lock-mode +1)

;; Frame and cursor looking
(blink-cursor-mode t)
(menu-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(tool-bar-mode -1)

(setq-default horizontal-scroll-bar nil
              indent-tabs-mode nil
              gc-cons-threshold (* gc-cons-threshold 10)
              echo-keystrokes 0
              indicate-empty-lines t
              indicate-buffer-boundaries 'right
              backup-inhibited t
              ring-bell-function #'ignore
              use-dialog-box nil
              history-length 500
              history-delete-duplicates t
              make-pointer-invisible t
              fill-column 80)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(when window-system
  (set-scroll-bar-mode 'nil))

;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)
(fset 'yes-or-no-p #'y-or-n-p)

;; Don't disable commands
(dolist (cmd '(narrow-to-region upcase-region downcase-region set-goal-column))
  (put cmd 'disabled nil))

(savehist-mode 1)
(save-place-mode +1)

(require 'server)
(unless (server-running-p)
  (server-start))

;; which-func
(which-function-mode +1)
(setq-default which-func-unknown "")

;; smart repetition
(require 'smartrep)
(custom-set-variables
 '(smartrep-mode-line-active-bg nil)
 '(smartrep-mode-line-string-activated "<<< SmartRep >>>"))

(add-to-list 'auto-mode-alist '("/\\(?:LICENSE\\|Changes\\)\\'" . text-mode))

(defun my/text-mode-hook ()
  (when (string-prefix-p "Changes" (buffer-name))
    (setq-local company-backends '(company-ispell company-files company-dabbrev))
    (flyspell-mode +1)))
(add-hook 'text-mode-hook 'my/text-mode-hook)

(with-eval-after-load "text-mode"
  (define-key text-mode-map (kbd "C-M-i") 'company-complete))

(custom-set-variables
 '(hippie-expand-verbose nil)
 '(hippie-expand-try-functions-list
   '(try-expand-dabbrev
     try-complete-file-name
     try-complete-file-name-partially
     try-expand-dabbrev-all-buffers)))

(custom-set-variables
 '(which-key-lighter "")
 '(which-key-idle-delay 0.5))
(which-key-mode +1)

(winner-mode +1)

;; naming of same name file
(require 'uniquify)
(custom-set-variables
 '(uniquify-buffer-name-style 'post-forward-angle-brackets))

(with-eval-after-load 'bs
  (fset 'bs-message-without-log 'ignore))

;; search
;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu2-query-replace-regexp)
(global-set-key (kbd "ESC M-%") 'anzu2-query-replace-at-cursor)
(global-set-key (kbd "C-x %") 'anzu2-replace-at-cursor-thing)
(define-key isearch-mode-map [remap isearch-query-replace]  #'anzu2-isearch-query-replace)
(define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu2-isearch-query-replace-regexp)

;; anzu
(global-anzu2-mode +1)
(custom-set-variables
 '(anzu2-mode-lighter ""))

;; electrict-mode
(custom-set-variables
 '(electric-indent-mode nil))

(defvar my/electric-pair-enabled-modes
  '(c-mode
    c++-mode
    java-mode
    python-mode
    ruby-mode
    sh-mode
    js-mode
    go-mode
    css-mode
    cmake-mode
    cperl-mode
    markdown-mode
    gfm-mode
    sql-mode))

(dolist (mode my/electric-pair-enabled-modes)
  (add-hook (intern (concat (symbol-name mode) "-hook")) #'electric-pair-local-mode))

;;;; helm
(custom-set-variables
 '(helm-input-idle-delay 0)
 '(helm-exit-idle-delay 0)
 '(helm-candidate-number-limit 500)
 '(helm-find-files-doc-header "")
 '(helm-command-prefix-key nil))

(with-eval-after-load 'helm
  (helm-descbinds-mode +1)

  (define-key helm-map (kbd "C-p")   #'helm-previous-line)
  (define-key helm-map (kbd "C-n")   #'helm-next-line)
  (define-key helm-map (kbd "C-M-n") #'helm-next-source)
  (define-key helm-map (kbd "C-M-p") #'helm-previous-source))

(with-eval-after-load 'helm-files
  (remove-hook 'post-self-insert-hook 'helm-find-files--reset-level-tree)

  (define-key helm-find-files-map (kbd "C-M-u") #'helm-find-files-down-one-level)
  (define-key helm-find-files-map (kbd "C-c C-o") #'helm-ff-run-switch-other-window))

(with-eval-after-load 'helm-mode
  (helm-mode -1))

(with-eval-after-load 'helm-gtags2
  (define-key helm-gtags2-mode-map (kbd "M-t") #'helm-gtags2-find-tag)
  (define-key helm-gtags2-mode-map (kbd "M-r") #'helm-gtags2-find-rtag)
  (define-key helm-gtags2-mode-map (kbd "M-s") #'helm-gtags2-find-symbol)
  (define-key helm-gtags2-mode-map (kbd "M-g M-s") #'helm-gtags2-select)
  (define-key helm-gtags2-mode-map (kbd "C-c >") #'helm-gtags2-next-history)
  (define-key helm-gtags2-mode-map (kbd "C-c <") #'helm-gtags2-previous-history)
  (define-key helm-gtags2-mode-map (kbd "C-c z") #'helm-gtags2-tag-continue)
  (define-key helm-gtags2-mode-map (kbd "C-t") #'helm-gtags2-pop-stack))

(dolist (hook '(c-mode-common-hook
                java-mode-hook
                asm-mode-hook))
  (add-hook hook #'helm-gtags2-mode))

;; spelling
(with-eval-after-load 'ispell
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))
  (when (and ispell-program-name
             (and (string= (file-name-nondirectory ispell-program-name) "aspell")))
    (setq ispell-extra-args '("--lang=en_US" "--camel-case"))))


;; company-mode
(custom-set-variables
 '(company-selection-wrap-around t)
 '(company-idle-delay nil))

(global-company-mode +1)
;; suppress minibuffer message
(fset 'company-echo-show #'ignore)

(global-set-key (kbd "C-M-i") 'company-complete)

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

(define-key lisp-interaction-mode-map (kbd "C-M-i") 'company-elisp)
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; show paren
(show-paren-mode +1)

;;;; Paredit
(dolist (hook '(emacs-lisp-mode-hook
                lisp-mode-hook
                ielm-mode-hook
                scheme-mode-hook
                inferior-scheme-mode-hook
                clojure-mode-hook
                cider-repl-mode-hook
                sly-mrepl-mode-hook))
  (add-hook hook 'enable-paredit-mode))

(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "C-c C-q") 'paredit-reindent-defun)
  (define-key paredit-mode-map (kbd "C-c C-j") #'eval-print-last-sexp)
  (define-key paredit-mode-map (kbd "M-q") nil)
  (define-key paredit-mode-map (kbd "M-)") #'move-past-close-and-reindent))

(with-eval-after-load 'view
  (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
  (define-key view-mode-map (kbd "?") 'View-search-regexp-backward)
  (define-key view-mode-map (kbd "g") 'View-goto-line)
  (define-key view-mode-map (kbd "w") 'forward-word)
  (define-key view-mode-map (kbd "W") 'forward-symbol)
  (define-key view-mode-map (kbd "b") 'backward-word)
  (define-key view-mode-map (kbd "h") 'backward-char)
  (define-key view-mode-map (kbd "j") 'next-line)
  (define-key view-mode-map (kbd "k") 'previous-line)
  (define-key view-mode-map (kbd "l") 'forward-char)
  (define-key view-mode-map (kbd "[") 'backward-paragraph)
  (define-key view-mode-map (kbd "]") 'forward-paragraph))

(with-eval-after-load 'doc-view
  (define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
  (define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page))

;;;; dired
(with-eval-after-load 'dired
  ;; Not create new buffer, if you chenge directory in dired
  (put 'dired-find-alternate-file 'disabled nil)

  (load-library "ls-lisp")

  ;; binding
  (define-key dired-mode-map (kbd "K") #'dired-k2)
  (define-key dired-mode-map (kbd "C-M-u") #'dired-up-directory)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))

(with-eval-after-load 'wdired
  (define-key wdired-mode-map (kbd "C-o") 'toggle-input-method))

(global-set-key (kbd "C-x C-j") #'dired-jump)


;;;; recentf-ext
(custom-set-variables
 '(recentf-max-saved-items 2000)
 '(recentf-auto-cleanup 600)
 '(recentf-exclude '("recentf" "/elpa/" "/elisps/" "\\`/tmp/" "/\\.git/" "/\\.cask/"
                     "/tmp/gomi/" "/el-get/" ".loaddefs.el" "/\\.cpanm/"
                     "\\.mime-example" "\\.ido.last" "woman_cache.el"
                     "\\`/proc/" "\\`/sys/"
                     "CMakeCache.txt" "/bookmarks" "\\.gz$"
                     "COMMIT_EDITMSG" "MERGE_MSG" "git-rebase-todo")))

(run-at-time t 600 #'editutil-recentf-save-list)
(recentf-mode 1)

;; sh-mode
(custom-set-variables
 '(sh-indentation 2))

;; compilation
(custom-set-variables
 '(compile-command "")
 '(compilation-always-kill t)
 '(compilation-message-face nil)
 '(compilation-auto-jump-to-first-error t)
 '(comint-input-ignoredups t))

(defun my/colorize-compilation-buffer ()
  (ansi-color-process-output nil))

(with-eval-after-load 'compile
  (add-hook 'compilation-filter-hook 'my/colorize-compilation-buffer))

(with-eval-after-load 'term-mode
  (define-key term-mode-map (kbd "C-z") elscreen-map)
  (define-key term-raw-map (kbd "C-z") elscreen-map))

;; eshell
(custom-set-variables
 '(eshell-banner-message "")
 '(eshell-cmpl-cycle-completions nil)
 '(eshell-hist-ignoredups t)
 '(eshell-scroll-show-maximum-output nil))

(setq-default eshell-path-env (getenv "PATH"))

(defun my/c-mode-hook ()
  (eglot-ensure)
  (c-set-style "k&r")
  (setq indent-tabs-mode t
        c-basic-offset 8)
  (c-toggle-electric-state -1))

(add-hook 'c-mode-hook #'my/c-mode-hook)
(add-hook 'c++-mode-hook #'my/c-mode-hook)

(with-eval-after-load 'c-mode
  (define-key c-mode-base-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c-mode-base-map (kbd "C-c C-s") #'clang-format-buffer))

(with-eval-after-load 'c++-mode
  (define-key c++-mode-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c-mode-base-map (kbd "C-c C-s") #'clang-format-buffer))

(with-eval-after-load 'asm-mode
  (define-key asm-mode-map (kbd "RET") 'newline))

;;;; cperl-mode
(add-to-list 'auto-mode-alist
             '("\\.\\(pl\\|pm\\|cgi\\|t\\|psgi\\)\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile\\'" . cperl-mode))
(defalias 'perl-mode 'cperl-mode)

(with-eval-after-load 'cperl-mode
  (cperl-set-style "PerlStyle")
  (setq cperl-auto-newline nil)

  ;; bindings
  (define-key cperl-mode-map "\177" nil)
  (define-key cperl-mode-map (kbd ";") nil)
  (define-key cperl-mode-map (kbd ":") nil)
  (define-key cperl-mode-map (kbd "(") nil)
  (define-key cperl-mode-map (kbd "{") nil)
  (define-key cperl-mode-map (kbd "}") nil)
  (define-key cperl-mode-map (kbd "[") nil))

(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset -4)
 '(cperl-indent-subs-specially nil))

;; setting for emacs-lisp
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'eldoc-mode)
  (add-hook hook 'elisp-slime-nav-mode))

(custom-set-variables
 '(eldoc-idle-delay 0.2))

(setq-default edebug-inhibit-emacs-lisp-mode-bindings t)

(defun my/elisp-mode-hook ()
  (setq-local company-backends '(company-elisp (company-dabbrev-code company-keywords) company-dabbrev)))

(add-hook 'emacs-lisp-mode-hook 'my/elisp-mode-hook)

;; go
(custom-set-variables
 '(gofmt-command "goimports"))

(with-eval-after-load 'go-mode
  (define-key go-mode-map (kbd "M-.") 'godef-jump)
  (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)
  (define-key go-mode-map (kbd ":") nil))

;; markdown
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(custom-set-variables
 '(markdown-indent-on-enter nil)
 '(markdown-gfm-use-electric-backquote nil)
 '(markdown-make-gfm-checkboxes-buttons))

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-M-i") 'company-complete))

(defun my/markdown-mode-hook ()
  (setq-local company-backends '(company-ispell company-files company-dabbrev))
  (make-local-variable 'electric-pair-pairs)
  (add-to-list 'electric-pair-pairs '(?` . ?`))
  (setq-local tab-width 8))
(add-hook 'markdown-mode-hook 'my/markdown-mode-hook t)

;;;; Common VCS setting
(custom-set-variables
 '(auto-revert-check-vc-info t)
 '(auto-revert-mode-text "")
 '(vc-handled-backends '(Git))
 '(vc-follow-symlinks t))
(global-auto-revert-mode 1)

(with-eval-after-load 'vc
  '(remove-hook 'find-file-hooks #'vc-find-file-hook))

;; vc
(global-set-key (kbd "C-x v d") #'vc-diff)

;; git-gutter
(global-git-gutter2-mode +1)
(global-set-key (kbd "C-x v u") #'git-gutter2-update)
(global-set-key (kbd "C-x v U") #'git-gutter2-cached)
(global-set-key (kbd "C-x v p") #'git-gutter2-stage-hunk)
(global-set-key (kbd "C-x v =") #'git-gutter2-popup-hunk)
(global-set-key (kbd "C-x v r") #'git-gutter2-revert-hunk)
(global-set-key (kbd "C-x v e") #'git-gutter2-end-of-hunk)

(custom-set-variables
 '(git-gutter2-verbosity 4)
 '(git-gutter2-modified-sign " ")
 '(git-gutter2-deleted-sign " "))

(add-hook 'focus-in-hook #'git-gutter2-update-all-windows)

(smartrep-define-key
 global-map  "C-x" '(("p" . 'git-gutter2-previous-hunk)
                     ("n" . 'git-gutter2-next-hunk)))

(global-set-key (kbd "C-x v m") #'git-messenger2-popup-message)

;; elscreen
(elscreen-start)
(global-set-key (kbd "C-z C-z") 'elscreen-toggle)
(global-set-key (kbd "C-z ,") 'elscreen-screen-nickname)
(global-set-key (kbd "C-z C") 'elscreen-editutil-clone-only-this-window)
(global-set-key (kbd "C-z C-l") 'helm-editutil-elscreen)
(run-with-idle-timer 20 t 'elscreen-editutil-update-frame-title)

(custom-set-variables
 '(elscreen-display-screen-number nil)
 '(elscreen-tab-display-kill-screen nil)

 '(elscreen-mode-to-nickname-alist
   '(("^dired-mode$" . (lambda () (format "Dired(%s/)" (buffer-name))))
     ("^Info-mode$" . (lambda ()
                        (format "Info(%s)" (file-name-nondirectory Info-current-file))))))

 '(elscreen-buffer-to-nickname-alist
   '(("Minibuf". ""))))

;; Don't show tab number in mode-line
(setq-default elscreen-mode-line-string nil)
(remove-hook 'elscreen-screen-update-hook 'elscreen-mode-line-update)
(add-hook 'elscreen-screen-update-hook 'elscreen-editutil-update-frame-title)
(elscreen-toggle-display-tab)

;; change cursor color 'enable input method' / 'disable input method'
(defun my/input-method-active-hook ()
  (when (memq major-mode my/electric-pair-enabled-modes)
    (electric-pair-local-mode -1))
  (set-cursor-color "gold"))

(defun my/input-method-inactivate-hook ()
  (when (memq major-mode my/electric-pair-enabled-modes)
    (electric-pair-local-mode +1))
  (set-cursor-color "chartreuse2"))

(add-hook 'input-method-activate-hook 'my/input-method-active-hook)
(add-hook 'input-method-deactivate-hook 'my/input-method-inactivate-hook)

;; This value should be set before loading `mozc.el'
(custom-set-variables
 '(mozc-candidate-style 'echo-area) ;; overlay is too slow
 '(mozc-leim-title "[も]"))

(when (and (require 'mozc nil t) (executable-find "mozc_emacs_helper"))
  (setq default-input-method "japanese-mozc")
  (global-set-key (kbd "C-o") 'toggle-input-method))

;;;; global key setting
(global-set-key (kbd "M-,") #'pop-tag-mark)
(global-set-key (kbd "M-*") #'tags-loop-continue)
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-=") 'yas-insert-snippet)
(global-set-key (kbd "C-x z") #'zoom-window2-zoom)
(global-set-key (kbd "C-x RET R") #'revert-buffer)
(global-set-key (kbd "C-x j") #'jump-to-register)
(global-set-key (kbd "C-x SPC") #'point-to-register)
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; unset keys
(global-unset-key (kbd "C-x C-n"))

;; helm binding
(global-set-key (kbd "C-M-z") #'helm-resume)
(global-set-key (kbd "C-x C-c") #'helm-M-x)
(global-set-key (kbd "C-M-y") #'helm-show-kill-ring)
(global-set-key (kbd "C-h a") #'helm-apropos)
(global-set-key (kbd "C-h m") #'helm-man-woman)
(global-set-key (kbd "C-x C-i") #'helm-imenu)
(global-set-key (kbd "C-x b") #'helm-buffers-list)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)

(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'flyspell-mode)

(smartrep-define-key
 global-map "C-q" '(("-" . 'goto-last-change)
                    ("+" . 'goto-last-change-reverse)))

;; editutil mappings
(editutil-default-setup)
(global-set-key (kbd "C-x c") ctl-x-4-map)

;; M-g mapping
(global-set-key (kbd "M-g .") #'helm-ag2)
(global-set-key (kbd "M-g ,") #'helm-ag2-pop-stack)
(global-set-key (kbd "M-g p") #'helm-ag2-project-root)
(global-set-key (kbd "M-g f") #'helm-do-ag2-this-file)
(global-set-key (kbd "M-g r") #'recompile)
(global-set-key (kbd "M-g q") #'quickrun2)

;;; buffer-move
(global-set-key (kbd "M-g h") #'buf-move-left)
(global-set-key (kbd "M-g j") #'buf-move-down)
(global-set-key (kbd "M-g k") #'buf-move-up)
(global-set-key (kbd "M-g l") #'buf-move-right)

;; font
;; Linux specific configuration
(custom-set-variables
 '(browse-url-browser-function #'browse-url-xdg-open))

;; font-setting for Linux(Ubuntu)
(let ((size (if (>= (x-display-pixel-width) 1900) 14 10)))
  (condition-case err
      (let ((myfont (format "VL ゴシック-%d" size)))
        (set-frame-font myfont)
        (add-to-list 'default-frame-alist `(font . ,myfont)))
    (error (message "%s" err))))
