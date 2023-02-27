;; -*- lexical-binding: t -*-

(custom-set-variables
 '(custom-file "~/.emacs.d/custom.el")
 '(anzu2-deactivate-region t)
 '(anzu2-mode-lighter "")
 '(anzu2-replace-to-string-separator " => ")
 '(auto-revert-check-vc-info t)
 '(auto-revert-interval 10)
 '(dabbrev-case-fold-search nil)
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always)
 '(eldoc-echo-area-use-multiline-p nil)
 '(eldoc-idle-delay 0.2)
 '(electric-indent-mode nil)
 '(find-file-visit-truename t)
 '(git-gutter2-deleted-sign " ")
 '(git-gutter2-modified-sign " ")
 '(helm-candidate-number-limit 500)
 '(helm-command-prefix-key nil)
 '(helm-exit-idle-delay 0)
 '(helm-gtags2-pulse-at-cursor nil)
 '(helm-input-idle-delay 0)
 '(hippie-expand-try-functions-list
   '(try-expand-dabbrev try-complete-file-name try-complete-file-name-partially try-expand-dabbrev-all-buffers))
 '(hippie-expand-verbose nil)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold (* 25 1024 1024))
 '(ls-lisp-dirs-first t)
 '(markdown-gfm-use-electric-backquote nil)
 '(markdown-indent-on-enter nil)
 '(markdown-make-gfm-checkboxes-buttons nil)
 '(package-selected-packages
   '(anzu2 helm-ag2 editutil git-gutter2 helm-gtags2 company editutil smartrep git-gutter2 git-gutter2 paredit company-mode helm-gtags2 helm-gtags2 helm-ag2 helm-ag2 helm-descbinds helm yaml-ts-mode markdown-mode rust-mode fsharp-mode go-mode clang-format editutil anzu2 anzu2 jsonrpc queue))
 '(parens-require-spaces nil)
 '(read-file-name-completion-ignore-case t)
 '(recentf-exclude
   '(".recentf" "/repos/" "/elpa/" "/el-get/" "CMakeCache.txt" "/usr/local/share/emacs/"
     "\\.mime-example" "\\.ido.last" "/tmp/gomi/" "/\\.cpanm/"))
 '(recentf-max-saved-items 1000)
 '(set-mark-command-repeat-pop t)
 '(sh-indentation 2)
 '(show-paren-delay 0)
 '(show-paren-style 'expression)
 '(split-width-threshold 160)
 '(use-package-always-ensure t)
 '(vc-follow-symlinks t)
 '(vc-handled-backends '(Git))
 '(view-read-only t))

(when load-file-name
  (setq-default user-emacs-directory (file-name-directory load-file-name)))

(require 'cl-lib)
(require 'subr-x)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)

(cl-defun from-github (&key repo name rev)
  (unless (package-installed-p name)
    (let ((url (format "https://github.com/%s" repo)))
      (package-vc-install url rev nil name))))

(setq gc-cons-threshold (* gc-cons-threshold 10)
      ring-bell-function #'ignore)
(setq-default indent-tabs-mode nil
              echo-keystrokes 0)

(fset 'yes-or-no-p #'y-or-n-p)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(when (executable-find "mozc_emacs_helper")
  (use-package mozc
    :init
    (custom-set-variables
     '(mozc-candidate-style 'echo-area)
     '(mozc-leim-title "[も]"))
    :config
    (setq-default default-input-method "japanese-mozc")
    (global-set-key (kbd "C-o") 'toggle-input-method)

    (set-face-attribute 'mozc-cand-echo-area-candidate-face nil
                        :foreground "color-184")))

(global-font-lock-mode +1)
(transient-mark-mode +1)

;; indicate last line
(setq-default indicate-empty-lines t
              indicate-buffer-boundaries 'right)

;; not create backup file
(setq backup-inhibited t
      delete-auto-save-files t)

(normal-erase-is-backspace-mode -1)

(menu-bar-mode -1)
(line-number-mode +1)
(column-number-mode +1)
(which-function-mode +1)

(savehist-mode 1)
(save-place-mode +1)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(use-package anzu2
  :init (from-github :repo "syohex/emacs-anzu2" :name 'anzu2)
  :config
  (global-anzu2-mode +1)
  (set-face-attribute 'anzu2-mode-line nil
                      :foreground "color-226"
                      :weight 'extra-bold))

(use-package editutil
  :init (from-github :repo "syohex/emacs-editutil" :name 'editutil)
  :config
  (editutil-default-setup)
  (set-face-attribute 'editutil-clean-space nil
                      :foreground "purple")
  (set-face-attribute 'editutil-vc-branch nil
                      :foreground "color-202"
                      :weight 'extra-bold))

;; show-paren
(show-paren-mode 1)
(set-face-attribute 'show-paren-match nil
                    :background 'unspecified :foreground 'unspecified
                    :underline t :weight 'bold)
(set-face-background 'show-paren-match 'unspecified)

(require 'server)
(unless (server-running-p)
  (server-start))
(defalias 'exit 'save-buffers-kill-emacs)

(require 'uniquify)
(require 'recentf)
(run-at-time t 600 'recentf-save-list)
(recentf-mode +1)

(global-auto-revert-mode +1)
(electric-pair-mode +1)

(use-package eglot
  :defer t
  :init
  (dolist (hook '(c-mode-hook
                  c++-mode-hook
                  go-mode-hook
                  fsharp-mode-hook
                  python-mode-hook
                  rust-mode-hook))
    (add-hook hook #'eglot-ensure))
  :config
  (define-key eglot-mode-map (kbd "C-c i") #'eglot-inlay-hints-mode)

  (set-face-foreground 'eglot-mode-line "color-166")
  (set-face-attribute 'eglot-inlay-hint-face nil
                      :foreground "color-83" :weight 'unspecified :italic t))

(use-package clang-format
  :defer t)

(with-eval-after-load 'cc-mode
  (define-key c-mode-map (kbd "M-q") nil)
  (define-key c-mode-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c-mode-map (kbd "C-c C-f") #'clang-format-buffer)

  (define-key c++-mode-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c++-mode-map (kbd "C-c C-f") #'clang-format-buffer))

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (hs-minor-mode 1)
  (c-toggle-electric-state -1)
  (setq c-basic-offset 4)
  (helm-gtags2-mode +1))

(add-hook 'c-mode-hook 'my/c-mode-hook)
(add-hook 'c++-mode-hook 'my/c-mode-hook)

(use-package go-mode
  :defer t
  :config
  (define-key go-mode-map (kbd "M-.") #'godef-jump)
  (define-key go-mode-map (kbd "M-,") #'pop-tag-mark)
  (define-key go-mode-map (kbd ":") nil))

(use-package eglot-fsharp
  :defer t)

(use-package fsharp-mode
  :defer t
  :config
  (require 'eglot-fsharp)
  (add-hook 'fsharp-mode-hook #'my/fsharp-mode-hook))

(defun my/fsharp-mode-hook ()
  (setq-local indent-line-function #'indent-relative))

(add-to-list 'auto-mode-alist '("\\(?:cpanfile\\|\\.t\\)\\'" . perl-mode))

(use-package rust-mode
  :defer t
  :config
  (set-face-attribute 'rust-string-interpolation nil
                      :foreground "color-81"
                      :slant 'unspecified))

(with-eval-after-load 'dired
  ;; Not create new buffer, if you chenge directory in dired
  (put 'dired-find-alternate-file 'disabled nil)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
  ;; display directories by first
  (load-library "ls-lisp"))

(use-package markdown-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  :config
  (define-key markdown-mode-map (kbd "C-x n") nil)
  (define-key markdown-mode-map (kbd "C-x n b") nil)
  (define-key markdown-mode-map (kbd "C-x n s") nil)
  (set-face-attribute 'markdown-line-break-face nil
                      :underline 'unspecified))

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))

(use-package helm
  :config
  (require 'helm-mode)
  (helm-mode -1)

  (require 'helm-files)
  (setq helm-find-files-doc-header "")

  (define-key helm-map (kbd "C-q") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-p") #'helm-previous-line)
  (define-key helm-map (kbd "C-n") #'helm-next-line)
  (define-key helm-map (kbd "C-M-p") #'helm-previous-source)
  (define-key helm-map (kbd "C-M-n") #'helm-next-source)

  (set-face-attribute 'helm-grep-file nil
                      :foreground "color-120"
                      :underline 'unspecified)
  (set-face-attribute 'helm-selection nil
                      :foreground "black"
                      :background "color-204"))

(use-package helm-descbinds
  :config
  (helm-descbinds-install))

(use-package helm-ag2
  :defer t
  :commands (helm-ag2 helm-do-ag2 helm-ag2-project-root)
  :init (from-github :repo "syohex/emacs-helm-ag2" :name 'helm-ag2))

(use-package helm-gtags2
  :defer t
  :commands (helm-gtags2-mode)
  :init (from-github :repo "syohex/emacs-helm-gtags2" :name 'helm-gtags2)
  :config
  (define-key helm-gtags2-mode-map (kbd "C-c t") #'helm-gtags2-find-tag)
  (define-key helm-gtags2-mode-map (kbd "C-c r") #'helm-gtags2-find-rtag)
  (define-key helm-gtags2-mode-map (kbd "C-c s") #'helm-gtags2-find-symbol)
  (define-key helm-gtags2-mode-map (kbd "C-c >") #'helm-gtags2-next-history)
  (define-key helm-gtags2-mode-map (kbd "C-c <") #'helm-gtags2-previous-history)
  (define-key helm-gtags2-mode-map (kbd "C-c ,") #'helm-gtags2-pop-stack))

(use-package company
  :config
  (global-company-mode +1)
  (global-set-key (kbd "C-M-i") #'company-complete)

  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "C-s") #'company-filter-candidates)
  (define-key company-active-map (kbd "C-i") #'company-complete-selection))

(define-key lisp-interaction-mode-map (kbd "C-M-i") #'company-elisp)
(define-key emacs-lisp-mode-map (kbd "C-M-i") #'company-complete)

(use-package paredit
  :defer t
  :init
  (dolist (hook '(emacs-lisp-mode-hook
                  lisp-interaction-mode-hook
                  lisp-mode-hook))
    (add-hook hook 'enable-paredit-mode)))

(use-package git-gutter2
  :init (from-github :repo "syohex/emacs-git-gutter2" :name 'git-gutter2)
  :config
  (global-git-gutter2-mode +1)

  (global-set-key (kbd "C-x v =") 'git-gutter2-popup-hunk)
  (global-set-key (kbd "C-x v u") 'git-gutter2-update)
  (global-set-key (kbd "C-x v r") 'git-gutter2-revert-hunk)

  (global-set-key (kbd "C-x n") 'git-gutter2-next-hunk)
  (global-set-key (kbd "C-x p") 'git-gutter2-previous-hunk)

  (set-face-attribute 'git-gutter2-deleted nil
                      :foreground 'unspecified
                      :background "brightred")
  (set-face-attribute 'git-gutter2-modified nil
                      :foreground 'unspecified
                      :background "brightmagenta"))

(use-package smartrep
  :config
  (smartrep-define-key
    global-map "C-x" '(("n" . 'git-gutter2-next-hunk)
                       ("p" . 'git-gutter2-previous-hunk))))

;; key mapping
(global-unset-key (kbd "C-x w"))
(global-set-key [delete] #'delete-char)
(global-set-key (kbd "M-ESC ESC") #'keyboard-quit)
(global-set-key (kbd "M-k") #'kill-whole-line)
(global-set-key (kbd "C-s") #'isearch-forward-regexp)
(global-set-key (kbd "C-r") #'isearch-backward-regexp)
(global-set-key (kbd "M-%") #'anzu2-query-replace-regexp)
(global-set-key (kbd "ESC M-%") #'anzu2-query-replace-at-cursor)
(global-set-key (kbd "C-x %") #'anzu2-replace-at-cursor-thing)
(global-set-key (kbd "C-M-c") #'duplicate-dwim)
(global-set-key (kbd "C-M-z") #'helm-resume)
(global-set-key (kbd "C-x !") #'eglot-rename)
(global-set-key (kbd "C-x M-.") #'xref-find-references)
(global-set-key (kbd "C-x C-i") #'helm-imenu)
(global-set-key (kbd "C-x C-c") #'helm-M-x)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "C-x C-j") #'dired-jump)
(global-set-key (kbd "C-x v d") #'vc-diff)
(global-set-key (kbd "M-g .") #'helm-ag2)
(global-set-key (kbd "M-g ,") #'helm-ag2-pop-stack)
(global-set-key (kbd "M-g p") #'helm-ag2-project-root)
(global-set-key (kbd "M-g e") #'evil-mode)
(global-set-key (kbd "M-g f") #'helm-do-ag2-project-root)
(global-set-key (kbd "M-g h") #'eldoc-doc-buffer)
(global-set-key (kbd "M-g l") #'flymake-show-buffer-diagnostics)
(global-set-key (kbd "C-x w") #'window-configuration-to-register)
(global-set-key (kbd "C-M-y") #'helm-show-kill-ring)
(global-set-key (kbd "C-h a") #'helm-apropos)

;; face
(set-face-foreground 'font-lock-string-face "color-215")
(set-face-foreground 'font-lock-comment-face "color-208")
(set-face-foreground 'font-lock-builtin-face "color-87")
(set-face-foreground 'font-lock-keyword-face "color-159")
(set-face-foreground 'font-lock-constant-face "color-82")
(set-face-foreground 'font-lock-variable-name-face "color-222")
(set-face-foreground 'font-lock-type-face "color-83")
(set-face-foreground 'font-lock-function-name-face "color-81")
(set-face-foreground 'minibuffer-prompt "color-46")
(set-face-foreground 'shadow "color-249")
(set-face-foreground 'link "color-39")
(set-face-foreground 'completions-common-part "color-190")
(set-face-attribute 'region nil
                    :foreground "color-240"
                    :background "color-159")
(set-face-attribute 'mode-line nil
                    :foreground "color-248"
                    :background "color-238")
(set-face-attribute 'mode-line-inactive nil
                    :foreground "color-254"
                    :background "color-247")
(set-face-attribute 'mode-line-buffer-id nil
                    :weight 'extra-bold)
(set-face-attribute 'which-func nil
                    :foreground "color-201"
                    :weight 'extra-bold)
(set-face-foreground 'font-lock-regexp-grouping-backslash "color-199")
(set-face-foreground 'font-lock-regexp-grouping-construct "color-190")
(set-face-attribute 'eldoc-highlight-function-argument nil
                    :foreground "color-82"
                    :weight 'extra-bold)

(with-eval-after-load 'org-faces
  (set-face-foreground 'org-formula "color-163")
  (set-face-foreground 'org-table "color-33"))

(with-eval-after-load 'flyspell
  (set-face-attribute 'flyspell-duplicate nil
                      :foreground "color-228")
  (set-face-attribute 'flyspell-incorrect nil
                      :foreground "color-198"
                      :underline t))

(with-eval-after-load 'flymake
  (set-face-attribute 'flymake-error nil
                      :foreground "color-199" :underline t)
  (set-face-attribute 'flymake-warning nil
                      :foreground "color-228" :underline t))

(with-eval-after-load 'diff-mode
  (set-face-attribute 'diff-added nil
                      :background 'unspecified :foreground "green"
                      :weight 'normal)
  (set-face-attribute 'diff-removed nil
                      :background 'unspecified :foreground "brightred"
                      :weight 'normal)
  (set-face-attribute 'diff-header nil
                      :background "color-240" :weight 'extra-bold)
  (set-face-attribute 'diff-file-header nil
                      :background "color-240" :weight 'bold)
  (set-face-attribute 'diff-refine-added nil
                      :background 'unspecified :underline t)
  (set-face-attribute 'diff-refine-removed nil
                      :background 'unspecified :underline t)
  (set-face-attribute 'diff-refine-changed nil
                      :background 'unspecified)
  (set-face-attribute 'diff-hunk-header nil
                      :foreground "color-208"
                      :weight 'extra-bold
                      :underline t))
