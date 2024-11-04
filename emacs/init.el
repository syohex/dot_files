;; -*- lexical-binding: t -*-

(custom-set-variables
 '(custom-file "~/.emacs.d/custom.el")
 '(confirm-kill-processes nil)
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
 '(edebug-inhibit-emacs-lisp-mode-bindings t)
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
 '(helm-move-to-line-cycle-in-source nil)
 '(hippie-expand-try-functions-list
   '(try-expand-dabbrev try-complete-file-name try-complete-file-name-partially try-expand-dabbrev-all-buffers))
 '(hippie-expand-verbose nil)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold (* 25 1024 1024))
 '(ls-lisp-dirs-first t)
 '(markdown-gfm-use-electric-backquote nil)
 '(markdown-indent-on-enter nil)
 '(markdown-make-gfm-checkboxes-buttons nil)
 '(parens-require-spaces nil)
 '(read-file-name-completion-ignore-case t)
 '(recentf-exclude
   '(".recentf" "/repos/" "/elpa/" "/el-get/" "CMakeCache.txt" "/usr/local/share/emacs/"
     "\\.mime-example" "\\.ido.last" "/tmp/gomi/" "/\\.cpanm/" "/Mail/" "\\.newsrc.*"))
 '(recentf-max-saved-items 1000)
 '(set-mark-command-repeat-pop t)
 '(sh-indentation 2)
 '(js-indent-level 2)
 '(show-paren-delay 0)
 '(show-paren-style 'expression)
 '(split-width-threshold 160)
 '(use-short-answers t)
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

(setq gc-cons-threshold (* gc-cons-threshold 10)
      ring-bell-function #'ignore)
(setq-default indent-tabs-mode nil
              echo-keystrokes 0)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

;; disable keys
(global-unset-key (kbd "C-x w"))
(global-unset-key (kbd "C-x @"))
(global-unset-key (kbd "C-x a"))

(when (executable-find "mozc_emacs_helper")
  (use-package mozc
    :init
    (custom-set-variables
     '(mozc-candidate-style 'echo-area)
     '(mozc-leim-title "[も]"))
    :config
    (setq-default default-input-method "japanese-mozc")
    (global-set-key (kbd "C-o") 'toggle-input-method)))

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
  :vc (:url "https://github.com/syohex/emacs-anzu2.git" :rev :newest)
  :config
  (global-anzu2-mode +1))

(use-package editutil
  :vc (:url "https://github.com/syohex/emacs-editutil.git" :rev :newest)
  :config
  (editutil-default-setup))

(use-package syohex-theme
  :vc (:url "https://github.com/syohex/emacs-syohex-theme.git" :rev :newest)
  :init
  (if (display-graphic-p)
      (load-theme 'syohex t)
    (load-theme 'syohex-terminal t)))

(when (display-graphic-p)
  (set-frame-size nil 130 50)
  (set-frame-font "HackGen Console-12")
  (tool-bar-mode -1))

;; show-paren
(show-paren-mode 1)

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
                  python-mode-hook
                  js-mode-hook
                  typescript-ts-mode-hook
                  tuareg-mode-hook
                  haskell-mode-hook
                  rust-mode-hook))
    (add-hook hook #'eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '((js-mode typescript-ts-mode tsx-ts-mode) . ("deno" "lsp" :initializationOptions (:enable t :lint t))))
  (setq eglot-ignored-server-capabilities '(:documentFormattingProvider
                                            :documentOnTypeFormattingProvider
                                            :documentRangeFormattingProvider))

  (define-key eglot-mode-map (kbd "C-c i") #'eglot-inlay-hints-mode)
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1))))

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
  (define-key go-mode-map (kbd "C-c C-f") #'gofmt)
  (define-key go-mode-map (kbd "C-c C-j") 'go-goto-map)
  (define-key go-mode-map (kbd "M-.") #'godef-jump)
  (define-key go-mode-map (kbd "M-,") #'pop-tag-mark)
  (define-key go-mode-map (kbd ":") nil))

(add-to-list 'major-mode-remap-alist '(csharp-mode . csharp-ts-mode))

(use-package haskell-mode
  :defer t
  :init
  (add-hook 'haskell-mode-hook #'interactive-haskell-mode)
  (with-eval-after-load 'haskell
    (define-key interactive-haskell-mode-map (kbd "C-c C-c") #'haskell-process-load-file)
    (define-key interactive-haskell-mode-map (kbd "C-c C-b") #'haskell-process-cabal-build))
  :config
  (define-key haskell-mode-map (kbd "C-j") #'haskell-indentation-newline-and-indent))

(use-package tuareg
  :defer t
  :config
  (define-key tuareg-mode-map (kbd "C-c C-l") #'tuareg-eval-buffer))

(add-to-list 'auto-mode-alist '("\\(?:cpanfile\\|\\.t\\)\\'" . perl-mode))

(use-package rust-mode
  :defer t)

(add-to-list 'auto-mode-alist '("\\.ts" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\(CMakeLists\\.txt\\|\\.cmake\\)\\'" . cmake-ts-mode))

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
  (define-key markdown-mode-map (kbd "C-x n s") nil))

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
  (define-key helm-map (kbd "C-M-n") #'helm-next-source))

(use-package helm-descbinds
  :config
  (helm-descbinds-install))

(use-package helm-ag2
  :defer t
  :commands (helm-ag2 helm-do-ag2 helm-ag2-project-root)
  :vc (:url "https://github.com/syohex/emacs-helm-ag2.git" :rev :newest))

(use-package helm-gtags2
  :defer t
  :commands (helm-gtags2-mode)
  :vc (:url "https://github.com/syohex/emacs-helm-gtags2.git" :rev :newest)
  :config
  (define-key helm-gtags2-mode-map (kbd "M-t") #'helm-gtags2-find-tag)
  (define-key helm-gtags2-mode-map (kbd "M-r") #'helm-gtags2-find-rtag)
  (define-key helm-gtags2-mode-map (kbd "M-s") #'helm-gtags2-find-symbol)
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
  :vc (:url "https://github.com/syohex/emacs-git-gutter2.git" :rev :newest)
  :config
  (global-git-gutter2-mode +1)

  (global-set-key (kbd "C-x v =") 'git-gutter2-popup-hunk)
  (global-set-key (kbd "C-x v u") 'git-gutter2-update)
  (global-set-key (kbd "C-x v r") 'git-gutter2-revert-hunk)

  (global-set-key (kbd "C-x n") 'git-gutter2-next-hunk)
  (global-set-key (kbd "C-x p") 'git-gutter2-previous-hunk))

(use-package smartrep
  :vc (:url "https://github.com/syohex/smartrep.el" :rev :newest)
  :config
  (smartrep-define-key
    global-map "C-x" '(("n" . 'git-gutter2-next-hunk)
                       ("p" . 'git-gutter2-previous-hunk))))

;; key mapping
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
(global-set-key (kbd "C-x m") #'eldoc-doc-buffer)
(global-set-key (kbd "C-x M-.") #'xref-find-references)
(global-set-key (kbd "C-x C-i") #'helm-imenu)
(global-set-key (kbd "C-x C-c") #'helm-M-x)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "C-x C-j") #'dired-jump)
(global-set-key (kbd "C-x v d") #'vc-diff)
(global-set-key (kbd "M-g .") #'helm-ag2)
(global-set-key (kbd "M-g ,") #'helm-ag2-pop-stack)
(global-set-key (kbd "M-g p") #'helm-ag2-project-root)
(global-set-key (kbd "M-g f") #'helm-do-ag2-project-root)
(global-set-key (kbd "M-g l") #'flymake-show-buffer-diagnostics)
(global-set-key (kbd "C-x w") #'window-configuration-to-register)
(global-set-key (kbd "C-M-y") #'helm-show-kill-ring)
(global-set-key (kbd "C-h a") #'helm-apropos)
(global-set-key (kbd "C-x [") #'beginning-of-buffer)
(global-set-key (kbd "C-x ]") #'end-of-buffer)
(global-set-key (kbd "C-x @") #'pop-global-mark)
