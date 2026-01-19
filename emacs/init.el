;; -*- lexical-binding: t -*-

(setopt confirm-kill-processes nil
        custom-file "~/.emacs.d/custom.el"
        dabbrev-case-fold-search nil
        electric-indent-mode nil
        find-file-visit-truename t
        inhibit-startup-screen t
        large-file-warning-threshold (* 25 1024 1024)
        ls-lisp-dirs-first t
        parens-require-spaces nil
        read-file-name-completion-ignore-case t
        scroll-preserve-screen-position t
        split-width-threshold 160
        use-short-answers t
        view-read-only t
        dired-auto-revert-buffer t
        dired-dwim-target t
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        imenu-auto-rescan t
        xref-search-program 'ripgrep
        eshell-banner-message "")

(when load-file-name
  (setq-default user-emacs-directory (file-name-directory load-file-name)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)

(setopt use-package-always-ensure t)

(use-package compile
  :config
  (setopt compilation-ask-about-save nil
          compile-command ""))

(use-package vc
  :config
  (setopt vc-follow-symlinks t
          vc-allow-rewriting-published-history 'ask
          log-edit-hook '(log-edit-insert-message-template log-edit-maybe-show-diff)
          vc-handled-backends '(Git)
          vc-git-diff-switches '("--stat")
          vc-git-log-switches '("--stat")))

(use-package flymake
  :config
  (setopt flymake-margin-indicators-string '((error "x" compilation-error)
                                             (warning "!" compilation-warning)
                                             (note "!" compilation-info))))

(use-package paren
  :config
  (setopt show-paren-delay 0
          show-paren-style 'expression))

(use-package hippie-exp
  :config
  (setopt hippie-expand-try-functions-list '(try-expand-dabbrev try-complete-file-name try-complete-file-name-partially try-expand-dabbrev-all-buffers)
          hippie-expand-verbose nil))

(use-package eldoc
  :config
  (setopt eldoc-echo-area-use-multiline-p nil
          eldoc-idle-delay 0.2))

(setq gc-cons-threshold (* gc-cons-threshold 10)
      ring-bell-function #'ignore)
(setq-default indent-tabs-mode nil
              echo-keystrokes 0
              edebug-inhibit-emacs-lisp-mode-bindings t)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(when (executable-find "mozc_emacs_helper")
  (use-package mozc
    :init
    (setopt mozc-candidate-style 'echo-area
            mozc-leim-title "[も]")
    :config
    (setq-default default-input-method "japanese-mozc")
    (keymap-global-set (kbd "C-o") 'toggle-input-method)))

;; not create backup file
(setq backup-inhibited t
      delete-auto-save-files t)

(normal-erase-is-backspace-mode -1)

(menu-bar-mode -1)
(column-number-mode +1)
(which-function-mode +1)

(savehist-mode 1)
(save-place-mode +1)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(with-eval-after-load 'compile
  (setq-default compilation-mode-line-errors nil))

(use-package anzu2
  :vc (:url "https://github.com/syohex/emacs-anzu2.git" :rev :newest)
  :config
  (global-anzu2-mode +1))

(use-package editutil
  :vc (:url "https://github.com/syohex/emacs-editutil.git" :rev :newest)
  :config
  (editutil-default-setup)

  (keymap-set editutil-ctrl-q-map "e" #'evil-mode)
  (keymap-set editutil-ctrl-q-map "p" project-prefix-map))

(use-package syohex-theme
  :vc (:url "https://github.com/syohex/emacs-syohex-theme.git" :rev :newest)
  :config
  (load-theme 'syohex t))

(show-paren-mode +1)
(fido-vertical-mode +1)

(require 'uniquify)

(use-package recentf
  :config
  (setopt recentf-exclude '(".recentf" "/elpa/" "CMakeCache.txt" "/usr/local/share/emacs/" "/.git/"
                            "\\.mime-example" "\\.ido.last" "/tmp/" "/\\.cpanm/" "/Mail/" "\\.newsrc.*")
          recentf-max-saved-items 1000)
  (recentf-mode +1))

(use-package autorevert
  :config
  (setopt auto-revert-check-vc-info t
          auto-revert-interval 10)
  (global-auto-revert-mode +1))

(electric-pair-mode +1)

(use-package eglot
  :defer t
  :hook ((c-mode
          c++-mode
          rust-ts-mode
          go-ts-mode
          python-mode
          js-mode
          type-script-ts-mode) . eglot-ensure)
  :config
  (setq eglot-ignored-server-capabilities '(:documentFormattingProvider
                                            :documentOnTypeFormattingProvider
                                            :documentRangeFormattingProvider)
        eglot-code-action-indicator "")

  (keymap-set eglot-mode-map "C-c i" #'eglot-inlay-hints-mode)
  (keymap-set eglot-mode-map "C-x ." #'eglot-code-actions)
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1))))

(with-eval-after-load 'cc-mode
  (advice-add 'c-update-modeline :around #'ignore)

  (keymap-set c-mode-map "M-q" nil)
  (keymap-set c-mode-map "C-c o" #'ff-find-other-file)
  (keymap-set c++-mode-map "C-c o" #'ff-find-other-file))

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (c-toggle-electric-state -1)
  (setq c-basic-offset 4)
  (setq-local comment-start "//" comment-end ""))

(add-hook 'c-mode-hook 'my/c-mode-hook)
(add-hook 'c++-mode-hook 'my/c-mode-hook)

(use-package sh-script
  :config
  (setopt sh-indentation 2))

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
(add-to-list 'auto-mode-alist '("\\(?:dune\\(?:-project\\)?\\)" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\(?:cpanfile\\|\\.t\\)\\'" . perl-mode))

(add-to-list 'auto-mode-alist '("\\.ts" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\(?:CMakeLists\\.txt\\|\\.cmake\\)\\'" . cmake-ts-mode))

(with-eval-after-load 'dired
  ;; Not create new buffer, if you chenge directory in dired
  (put 'dired-find-alternate-file 'disabled nil)
  (keymap-set dired-mode-map "RET" 'dired-find-alternate-file)
  (keymap-set dired-mode-map "r" 'wdired-change-to-wdired-mode)
  (keymap-set dired-mode-map "C-M-u" 'dired-up-directory)
  ;; display directories by first
  (load-library "ls-lisp"))

(with-eval-after-load 'esh-mode
  (keymap-set eshell-mode-map "C-x \\" #'previous-buffer))

(use-package markdown-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  :config
  (setq-default markdown-gfm-use-electric-backquote nil
                markdown-indent-on-enter nil
                markdown-make-gfm-checkboxes-buttons nil))

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))

(use-package company
  :config
  (global-company-mode +1)
  (global-set-key (kbd "C-M-i") #'company-complete)

  (add-hook 'eshell-mode-hook (lambda () (company-mode -1)))

  (keymap-set company-active-map "C-n" #'company-select-next)
  (keymap-set company-active-map "C-p" #'company-select-previous)
  (keymap-set company-active-map "C-s" #'company-filter-candidates)
  (keymap-set company-active-map "C-i" #'company-complete-selection))

(keymap-set lisp-interaction-mode-map "C-M-i" #'company-complete)
(keymap-set emacs-lisp-mode-map "C-M-i" #'company-complete)

(use-package paredit
  :defer t
  :config
  (keymap-set paredit-mode-map "M-s" nil)
  (keymap-set paredit-mode-map "M-s" search-map)
  (keymap-set paredit-mode-map "M-r" 'paredit-splice-sexp)
  (keymap-set paredit-mode-map "C-c C-s" #'paredit-splice-sexp)
  (keymap-set paredit-mode-map "C-c C-r" #'paredit-raise-sexp)
  :hook ((emacs-lisp-mode lisp-interaction-mode lisp-mode) . enable-paredit-mode))

(use-package git-gutter2
  :vc (:url "https://github.com/syohex/emacs-git-gutter2.git" :rev :newest)
  :config
  (global-git-gutter2-mode +1)

  (keymap-global-set "C-x v p" 'git-gutter2-popup-hunk)
  (keymap-global-set "C-x v u" 'git-gutter2-update)
  (keymap-global-set "C-x v r" 'git-gutter2-revert-hunk)
  (keymap-global-set "C-x v c" 'git-gutter2-clear-gutter)

  (keymap-global-set "C-x n" 'git-gutter2-next-hunk)
  (keymap-global-set "C-x p" 'git-gutter2-previous-hunk))

(use-package evil
  :config
  (setq-default evil-mode-line-format nil
                evil-symbol-word-search t)

  (evil-mode +1)
  (evil-set-toggle-key "C-x C-z")
  (evil-set-undo-system 'undo-redo)

  (add-hook 'suspend-hook (lambda ()
                            (when evil-mode
                              (evil-force-normal-state))))

  (dolist (mode '(log-edit-mode))
    (add-to-list 'evil-emacs-state-modes mode))

  (evil-define-key 'normal 'global (kbd "M-.") #'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "C-n") #'next-line)
  (evil-define-key 'normal 'global (kbd "C-p") #'previous-line)
  (evil-define-key 'normal 'global (kbd "C-n") #'next-line)
  (evil-define-key 'normal 'global (kbd "C-p") #'previous-line)
  (evil-define-key 'normal 'global (kbd "[ v") #'git-gutter2-previous-hunk)
  (evil-define-key 'normal 'global (kbd "] v") #'git-gutter2-next-hunk)
  (evil-define-key 'insert 'global (kbd "C-a") #'move-beginning-of-line)
  (evil-define-key 'insert 'global (kbd "C-e") #'move-end-of-line)
  (evil-define-key 'insert 'global (kbd "C-n") #'next-line)
  (evil-define-key 'insert 'global (kbd "C-p") #'previous-line)
  (evil-define-key 'insert 'global (kbd "C-y") #'editutil-yank)
  (evil-define-key 'insert 'global (kbd "C-k") #'editutil-kill-line)

  (evil-set-leader nil (kbd "SPC")))

;; key mapping
(keymap-global-set "<delete>" #'delete-char)
(keymap-global-set "C-s" #'isearch-forward-regexp)
(keymap-global-set "C-r" #'isearch-backward-regexp)
(keymap-global-set "M-%" #'anzu2-query-replace-regexp)
(keymap-global-set "ESC M-%" #'anzu2-query-replace-at-cursor)
(keymap-global-set "C-x %" #'anzu2-replace-at-cursor-thing)
(keymap-global-set "C-M-c" #'duplicate-dwim)
(keymap-global-set "C-x !" #'eglot-rename)
(keymap-global-set "C-h m" #'eldoc-doc-buffer)
(keymap-global-set "C-x C-i" #'imenu)
(keymap-global-set "C-x C-x" #'find-file)
(keymap-global-set "C-x \\" #'eshell)
(keymap-global-set "C-x M-." #'xref-find-references)
(keymap-global-set "C-x C-b" #'ibuffer)
(keymap-global-set "C-x C-r" #'recentf-open)
(keymap-global-set "C-x C-p" #'project-find-file)
(keymap-global-set "C-x C-j" #'dired-jump)
(keymap-global-set "C-x _" #'split-window-below)
(keymap-global-set "C-x |" #'split-window-right)
(keymap-global-set "M-g f" #'project-find-regexp)
(keymap-global-set "C-x w s" #'window-swap-states)
(keymap-global-set "C-x w |" #'window-layout-flip-leftright)
(keymap-global-set "C-x w _" #'window-layout-flip-topdown)
(keymap-global-set "M-j" #'repeat)
