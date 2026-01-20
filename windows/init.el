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
        visible-bell t
        eshell-banner-message "")

(setq-default indent-tabs-mode nil
              echo-keystrokes 0
              edebug-inhibit-emacs-lisp-mode-bindings t)

;; not create backup file
(setq backup-inhibited t
      delete-auto-save-files t)

(fido-vertical-mode +1)
(show-paren-mode +1)
(which-function-mode +1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(save-place-mode +1)

(electric-pair-mode +1)

(set-frame-font "HackGen Console 12" nil t)
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)

(setopt use-package-always-ensure t)

(use-package hippie-exp
  :config
  (setopt hippie-expand-try-functions-list
          '(try-expand-dabbrev
            try-complete-file-name
            try-complete-file-name-partially
            try-expand-dabbrev-all-buffers)
          hippie-expand-verbose nil))

(with-eval-after-load 'dired
  ;; Not create new buffer, if you chenge directory in dired
  (put 'dired-find-alternate-file 'disabled nil)
  (keymap-set dired-mode-map "RET" 'dired-find-alternate-file)
  (keymap-set dired-mode-map "r" 'wdired-change-to-wdired-mode)
  (keymap-set dired-mode-map "C-M-u" 'dired-up-directory))

(use-package vc
  :config
  (setopt vc-follow-symlinks t
          vc-handled-backends '(Git)))

(use-package paren
  :config
  (setopt show-paren-delay 0
          show-paren-style 'expression))

(use-package recentf
  :config
  (setopt recentf-exclude '(".recentf" "/elpa/" "CMakeCache.txt" "/share/emacs/" "/.git/"
                            "\\.mime-example" "\\.ido.last" "/tmp/" "/\\.cpanm/" "/Mail/" "\\.newsrc.*"
                            "/share/")
          recentf-max-saved-items 1000)
  (recentf-mode +1))

(use-package anzu2
  :vc (:url "https://github.com/syohex/emacs-anzu2.git" :rev :newest)
  :config
  (global-anzu2-mode +1)
  :bind
  (("M-%" . anzu2-query-replace-regexp)
   ("ESC M-%" . anzu2-query-replace-at-cursor)
   ("C-x %" . anzu2-replace-at-cursor-thing)))

(use-package editutil
  :vc (:url "https://github.com/syohex/emacs-editutil.git" :rev :newest)
  :config
  (editutil-default-setup))

(use-package syohex-theme
  :vc (:url "https://github.com/syohex/emacs-syohex-theme.git" :rev :newest)
  :config
  (load-theme 'syohex t))

(use-package markdown-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  :config
  (setq-default markdown-gfm-use-electric-backquote nil
                markdown-indent-on-enter nil
                markdown-make-gfm-checkboxes-buttons nil))

(use-package company
  :config
  (setopt company-backends
          '(company-capf company-files company-dabbrev-code company-keywords company-dabbrev))
  (global-company-mode +1)
  (add-hook 'eshell-mode-hook (lambda () (company-mode -1)))

  :bind
  (("C-M-i" . company-complete)
   :map company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("C-s" . company-filter-candidates)
   ("C-i" . company-complete-selection)
   :map lisp-interaction-mode-map
   ("C-M-i" . company-complete)
   :map emacs-lisp-mode-map
   ("C-M-i" . company-complete)))

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

  (evil-define-key 'normal 'global (kbd "M-.") #'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "C-n") #'next-line)
  (evil-define-key 'normal 'global (kbd "C-p") #'previous-line)
  (evil-define-key 'normal 'global (kbd "C-n") #'next-line)
  (evil-define-key 'normal 'global (kbd "C-p") #'previous-line)
  (evil-define-key 'insert 'global (kbd "C-a") #'move-beginning-of-line)
  (evil-define-key 'insert 'global (kbd "C-e") #'move-end-of-line)
  (evil-define-key 'insert 'global (kbd "C-n") #'next-line)
  (evil-define-key 'insert 'global (kbd "C-p") #'previous-line)
  (evil-define-key 'insert 'global (kbd "C-y") #'editutil-yank)
  (evil-define-key 'insert 'global (kbd "C-k") #'editutil-kill-line)

  (evil-set-leader nil (kbd "SPC")))

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (c-toggle-electric-state -1)
  (setq c-basic-offset 4)
  (setq-local comment-start "//" comment-end ""))

(add-hook 'c-mode-hook 'my/c-mode-hook)
(add-hook 'c++-mode-hook 'my/c-mode-hook)

(with-eval-after-load 'cc-mode
  (advice-add 'c-update-modeline :around #'ignore)

  (keymap-set c-mode-map "M-q" nil)
  (keymap-set c-mode-map "C-c o" #'ff-find-other-file)
  (keymap-set c++-mode-map "C-c o" #'ff-find-other-file))
