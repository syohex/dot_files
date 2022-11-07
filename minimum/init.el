;;; init.el --- my init.el -*- lexical-binding: t -*-

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(custom-set-variables
 '(split-width-threshold 0)
 '(read-file-name-completion-ignore-case t)
 '(dabbrev-case-fold-search nil)
 '(inhibit-startup-screen t)
 '(find-file-visit-truename t)
 '(large-file-warning-threshold (* 25 1024 1024))
 '(anzu2-deactivate-region t)
 '(anzu2-mode-lighter "")
 '(anzu2-replace-to-string-separator " => ")
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always)
 '(el-get-verbose t)
 '(eldoc-idle-delay 0.2)
 '(electric-indent-mode nil)
 '(evil-move-cursor-back nil)
 '(evil-search-module 'evil-search)
 '(helm-candidate-number-limit 500)
 '(helm-command-prefix-key nil)
 '(helm-exit-idle-delay 0)
 '(helm-gtags-pulse-at-cursor nil)
 '(helm-input-idle-delay 0)
 '(hippie-expand-try-functions-list
   '(try-expand-dabbrev try-complete-file-name try-complete-file-name-partially try-expand-dabbrev-all-buffers))
 '(hippie-expand-verbose nil)
 '(ls-lisp-dirs-first t)
 '(package-selected-packages '(jsonrpc queue))
 '(parens-require-spaces nil)
 '(set-mark-command-repeat-pop t)
 '(show-paren-delay 0)
 '(show-paren-style 'expression)
 '(view-read-only t)
 '(sh-indentation 2)
 '(warning-suppress-types '((el-get) ((package reinitialization)))))

(setq gc-cons-threshold (* gc-cons-threshold 10)
      ring-bell-function #'ignore)
(setq-default indent-tabs-mode nil
              echo-keystrokes 0)

(el-get-bundle syohex/emacs-editutil :name editutil)

(el-get-bundle syohex/emacs-anzu2 :name anzu2)
(el-get-bundle paredit)

(el-get-bundle company-mode/company-mode :name company-mode)

(el-get-bundle helm)

(el-get-bundle myuhe/smartrep.el :name smartrep)

(el-get-bundle jrblevin/markdown-mode)
(el-get-bundle yoshiki/yaml-mode)

(el-get-bundle syohex/emacs-git-gutter2 :name git-gutter2)

(el-get-bundle which-key)

(el-get-bundle emacs-helm/helm-descbinds)
(el-get-bundle syohex/emacs-helm-ag2 :name helm-ag2)
(el-get-bundle syohex/emacs-helm-gtags2 :name helm-gtags2)

(el-get-bundle emacsmirror/clang-format)
(el-get-bundle dominikh/go-mode.el)
(el-get-bundle fsharp/emacs-fsharp-mode)
(el-get-bundle rust-lang/rust-mode)
(el-get-bundle kotlin-mode)
(el-get-bundle haskell/haskell-mode)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(require 'cl-lib)

(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                lisp-mode-hook))
  (add-hook hook 'enable-paredit-mode))

(dolist (hook '(c-mode-hook
                c++-mode-hook
                python-mode-hook
                fsharp-mode-hook
                kotlin-mode-hook
                go-mode-hook
                sh-mode-hook
                js-mode-hook
                rust-mode-hook
                css-mode-hook
                cmake-mode-hook
                cperl-mode-hook
                markdown-mode-hook
                gfm-mode-hook
                yaml-mode-hook))
  (add-hook hook 'electric-pair-local-mode))

(require 'smartrep)

(savehist-mode 1)
(save-place-mode +1)

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-ESC ESC") 'keyboard-quit)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu2-query-replace-regexp)
(global-set-key (kbd "ESC M-%") 'anzu2-query-replace-at-cursor)
(global-set-key (kbd "C-x %") 'anzu2-replace-at-cursor-thing)
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "M-g .") 'helm-ag2)
(global-set-key (kbd "M-g ,") 'helm-ag2-pop-stack)
(global-set-key (kbd "M-g p") 'helm-ag2-project-root)
(global-set-key (kbd "M-g M-f") 'ffap)
(global-set-key (kbd "M-g M-l") 'flymake-show-buffer-diagnostics)

(global-font-lock-mode t)
(transient-mark-mode nil)

;; indicate last line
(setq-default indicate-empty-lines t
              indicate-buffer-boundaries 'right)

;; not create backup file
(setq backup-inhibited t
      delete-auto-save-files t)

;; Disable menu bar
(menu-bar-mode -1)

(show-paren-mode 1)
(line-number-mode 1)
(column-number-mode 1)

(require 'server)
(unless (server-running-p)
  (server-start))
(defalias 'exit 'save-buffers-kill-emacs)

;; backspace
(when (not window-system)
  (normal-erase-is-backspace-mode 0))

(with-eval-after-load 'cc-mode
  (define-key c-mode-map (kbd "M-q") 'nil)
  (define-key c-mode-map (kbd "C-c o") 'ff-find-other-file)
  (define-key c-mode-map (kbd "C-c C-f") 'clang-format-buffer)

  (define-key c++-mode-map (kbd "C-c o") 'ff-find-other-file)
  (define-key c++-mode-map (kbd "C-c C-f") 'clang-format-buffer))

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (hs-minor-mode 1)
  (c-toggle-electric-state -1)
  (setq c-basic-offset 4)
  (helm-gtags2-mode +1))

(add-hook 'c-mode-hook 'my/c-mode-hook)
(add-hook 'c++-mode-hook 'my/c-mode-hook)

(add-hook 'asm-mode-hook 'helm-gtags2-mode)

;; ibuffer
(defalias 'list-buffers 'ibuffer)

;;;; dired
(require 'dired)
;; Not create new buffer, if you chenge directory in dired
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)
(define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
(define-key dired-mode-map (kbd "K") 'dired-k)
(global-set-key (kbd "C-x C-j") #'dired-jump)
;; display directories by first
(load-library "ls-lisp")

;; helm
(require 'helm-config)
(require 'helm)
(require 'helm-mode)

(helm-mode -1)

(define-key helm-map (kbd "C-q") 'helm-execute-persistent-action)

(require 'helm-descbinds)
(helm-descbinds-install)

;; gtags
(with-eval-after-load 'helm-gtags2
  (define-key helm-gtags2-mode-map (kbd "M-t") 'helm-gtags2-find-tag)
  (define-key helm-gtags2-mode-map (kbd "M-r") 'helm-gtags2-find-rtag)
  (define-key helm-gtags2-mode-map (kbd "M-s") 'helm-gtags2-find-symbol)
  (define-key helm-gtags2-mode-map (kbd "C-c >") 'helm-gtags2-next-history)
  (define-key helm-gtags2-mode-map (kbd "C-c <") 'helm-gtags2-previous-history)
  (define-key helm-gtags2-mode-map (kbd "C-t") 'helm-gtags2-pop-stack))

(define-key helm-map (kbd "C-p") 'helm-previous-line)
(define-key helm-map (kbd "C-n") 'helm-next-line)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)

(global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-h a") 'helm-apropos)

;; helm faces
(require 'helm-files)
(setq helm-find-files-doc-header "")

;; naming of same name file
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(setq recentf-max-saved-items 1000)
(require 'recentf)
(run-at-time t 600 'recentf-save-list)
(setq recentf-exclude '(".recentf" "/repos/" "/elpa/" "/el-get/" "CMakeCache.txt"
                        "/usr/local/share/emacs/"
                        "\\.mime-example" "\\.ido.last" "/tmp/gomi/" "/\\.cpanm/"))
(recentf-mode +1)

;; for virsion control system
(global-auto-revert-mode 1)
(setq auto-revert-interval 10
      auto-revert-check-vc-info t
      vc-follow-symlinks t
      vc-handled-backends '(Git))

;; which-func
(require 'which-func)
(set-face-foreground 'which-func "color-201")
(set-face-bold-p 'which-func t)
(which-function-mode t)

(global-set-key (kbd "C-x v d") 'vc-diff)

;; company-mode
(require 'company)

(global-company-mode +1)
(global-set-key (kbd "C-M-i") 'company-complete)

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

(define-key lisp-interaction-mode-map (kbd "C-M-i") 'company-elisp)
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

(which-key-mode +1)

;; anzu
(global-anzu2-mode +1)

;; editutil
(require 'editutil)
(editutil-default-setup)

;; (makeunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  ""
  :global     t
  :lighter    ""
  `((,(kbd "M-q") . editutil-zap-to-char)
    (,(kbd "M-Q") . editutil-zap-to-char-backward)
    (,(kbd "M-a") . editutil-backward-char)
    (,(kbd "M-e") . editutil-forward-char)))

;; view-mode
(with-eval-after-load 'view
  (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
  (define-key view-mode-map (kbd "?") 'View-search-regexp-backward?)
  (define-key view-mode-map (kbd "g") 'View-goto-line)
  (define-key view-mode-map (kbd "G") 'editutil-goto-last-line)
  (define-key view-mode-map (kbd "f") 'editutil-forward-char)
  (define-key view-mode-map (kbd "F") 'editutil-backward-char)
  (define-key view-mode-map (kbd "w") 'forward-word)
  (define-key view-mode-map (kbd "b") 'backward-word)

  (define-key view-mode-map (kbd "i") 'editutil-view-insert)
  (define-key view-mode-map (kbd "a") 'editutil-view-insert-at-next)
  (define-key view-mode-map (kbd "I") 'editutil-view-insert-at-bol)
  (define-key view-mode-map (kbd "A") 'editutil-view-insert-at-eol)

  (define-key view-mode-map (kbd "h") 'backward-char)
  (define-key view-mode-map (kbd "j") 'next-line)
  (define-key view-mode-map (kbd "k") 'previous-line)
  (define-key view-mode-map (kbd "l") 'forward-char)
  (define-key view-mode-map (kbd "[") 'backward-paragraph)
  (define-key view-mode-map (kbd "]") 'forward-paragraph))

;; git-gutter
(global-git-gutter2-mode t)

(global-set-key (kbd "C-x v =") 'git-gutter2-popup-hunk)
(global-set-key (kbd "C-x v u") 'git-gutter2-update)
(global-set-key (kbd "C-x v r") 'git-gutter2-revert-hunk)

(global-set-key (kbd "C-x n") 'git-gutter2-next-hunk)
(global-set-key (kbd "C-x p") 'git-gutter2-previous-hunk)

(smartrep-define-key
 global-map "C-x" '(("n" . 'git-gutter2-next-hunk)
                    ("p" . 'git-gutter2-previous-hunk)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(with-eval-after-load 'markdown-mode
  (define-key markdown-mode-map (kbd "C-x n") nil)
  (define-key markdown-mode-map (kbd "C-x n b") nil)
  (define-key markdown-mode-map (kbd "C-x n s") nil))

(dolist (hook '(c-mode-hook
                c++-mode-hook
                go-mode-hook
                haskell-mode-hook
                python-mode-hook
                rust-mode-hook))
  (add-hook hook #'eglot-ensure))

(set-face-attribute 'mode-line nil
                    :foreground "color-248"
                    :background "color-238")
(set-face-attribute 'mode-line-inactive nil
                    :foreground "color-254"
                    :background "color-247")
(set-face-attribute 'mode-line-buffer-id nil
                    :weight 'extra-bold)
(set-face-attribute 'editutil-clean-space nil
                    :foreground "purple")
(set-face-attribute 'editutil-vc-branch nil
                    :foreground "color-202"
                    :weight 'extra-bold)
(set-face-attribute 'anzu2-mode-line nil
                    :foreground "color-226"
                    :weight 'extra-bold)
(set-face-attribute 'show-paren-match nil
                    :background 'unspecified :foreground 'unspecified
                    :underline t :weight 'bold)
(set-face-background 'show-paren-match 'unspecified)
(set-face-foreground 'font-lock-regexp-grouping-backslash "#ff1493")
(set-face-foreground 'font-lock-regexp-grouping-construct "#ff8c00")
(set-face-attribute 'helm-grep-file nil
                    :foreground "cyan"
                    :underline 'unspecified)

(with-eval-after-load 'eglot
  (set-face-attribute 'eglot-mode-line nil
                      :foreground "color-166"))
