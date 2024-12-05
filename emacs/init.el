;; -*- lexical-binding: t -*-

(custom-set-variables
 '(auto-revert-check-vc-info t)
 '(auto-revert-interval 10)
 '(confirm-kill-processes nil)
 '(compilation-ask-about-save nil)
 '(compile-command "")
 '(custom-file "~/.emacs.d/custom.el")
 '(dabbrev-case-fold-search nil)
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always)
 '(eldoc-echo-area-use-multiline-p nil)
 '(eldoc-idle-delay 0.2)
 '(electric-indent-mode nil)
 '(find-file-visit-truename t)
 '(flymake-margin-indicators-string '((error "x" compilation-error)
                                      (warning "!" compilation-warning)
                                      (note "!" compilation-info)))
 '(hippie-expand-try-functions-list
   '(try-expand-dabbrev try-complete-file-name try-complete-file-name-partially try-expand-dabbrev-all-buffers))
 '(hippie-expand-verbose nil)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold (* 25 1024 1024))
 '(ls-lisp-dirs-first t)
 '(parens-require-spaces nil)
 '(read-file-name-completion-ignore-case t)
 '(recentf-exclude
   '(".recentf" "/elpa/" "CMakeCache.txt" "/usr/local/share/emacs/" "/.git/"
     "\\.mime-example" "\\.ido.last" "/tmp/" "/\\.cpanm/" "/Mail/" "\\.newsrc.*"))
 '(recentf-max-saved-items 1000)
 '(sh-indentation 2)
 '(js-indent-level 2)
 '(scroll-preserve-screen-position t)
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

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)

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
    (custom-set-variables
     '(mozc-candidate-style 'echo-area)
     '(mozc-leim-title "[も]"))
    :config
    (setq-default default-input-method "japanese-mozc")
    (global-set-key (kbd "C-o") 'toggle-input-method)))

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

  (define-key editutil-ctrl-q-map (kbd "e") #'evil-mode)
  (define-key editutil-ctrl-q-map "p" project-prefix-map))

(use-package syohex-theme
  :vc (:url "https://github.com/syohex/emacs-syohex-theme.git" :rev :newest)
  :init
  (load-theme 'syohex-terminal t))

(show-paren-mode +1)

(require 'server)
(unless (server-running-p)
  (server-start))

(require 'uniquify)
(recentf-mode +1)

(global-auto-revert-mode +1)
(electric-pair-mode +1)

(use-package eglot
  :defer t
  :hook ((c-mode
          c++-mode
          rust-ts-mode
          go-ts-mode
          python-mode
          tuareg-mode
          haskell-mode
          js-mode
          type-script-ts-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '((js-mode typescript-ts-mode tsx-ts-mode) . ("deno" "lsp" :initializationOptions (:enable t :lint t))))
  (setq eglot-ignored-server-capabilities '(:documentFormattingProvider
                                            :documentOnTypeFormattingProvider
                                            :documentRangeFormattingProvider))

  (define-key eglot-mode-map (kbd "C-c i") #'eglot-inlay-hints-mode)
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1))))

(with-eval-after-load 'cc-mode
  (advice-add 'c-update-modeline :around #'ignore)

  (define-key c-mode-map (kbd "M-q") nil)
  (define-key c-mode-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c++-mode-map (kbd "C-c o") #'ff-find-other-file))

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (c-toggle-electric-state -1)
  (setq c-basic-offset 4)
  (setq-local comment-start "//" comment-end "")
  (helm-gtags2-mode +1))

(add-hook 'c-mode-hook 'my/c-mode-hook)
(add-hook 'c++-mode-hook 'my/c-mode-hook)

(use-package haskell-mode
  :defer t
  :hook ((haskell-mode . interactive-haskell-mode))
  :init
  (with-eval-after-load 'haskell
    (define-key interactive-haskell-mode-map (kbd "C-c C-c") #'haskell-process-load-file)
    (define-key interactive-haskell-mode-map (kbd "C-c C-b") #'haskell-process-cabal-build))
  :config
  (define-key haskell-mode-map (kbd "C-j") #'haskell-indentation-newline-and-indent))

(use-package tuareg
  :defer t)

(use-package utop
  :defer t
  :hook ((tuareg-mode . utop-minor-mode))
  :config
  (define-key utop-minor-mode-map (kbd "C-x C-r") nil)
  (define-key utop-minor-mode-map (kbd "C-c C-l") #'utop-eval-buffer))

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
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
  ;; display directories by first
  (load-library "ls-lisp"))

(with-eval-after-load 'esh-mode
  (define-key eshell-mode-map (kbd "C-x \\") #'previous-buffer))

(use-package markdown-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  :config
  (setq-default markdown-gfm-use-electric-backquote nil
                markdown-indent-on-enter nil
                markdown-make-gfm-checkboxes-buttons nil))

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))

(use-package helm
  :config
  (setq-default helm-input-idle-delay 0
                helm-move-to-line-cycle-in-source nil)

  (require 'helm-mode)
  (helm-mode -1)

  (require 'helm-files)
  (setq-default helm-find-files-doc-header "")

  (global-set-key (kbd "C-x c") nil)
  (define-key helm-map (kbd "C-q") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-p") #'helm-previous-line)
  (define-key helm-map (kbd "C-n") #'helm-next-line)
  (define-key helm-map (kbd "C-M-p") #'helm-previous-source)
  (define-key helm-map (kbd "C-M-n") #'helm-next-source))

(use-package helm-ag2
  :defer t
  :commands (helm-ag2 helm-do-ag2 helm-ag2-project-root)
  :vc (:url "https://github.com/syohex/emacs-helm-ag2.git" :rev :newest))

(use-package helm-gtags2
  :defer t
  :commands (helm-gtags2-mode)
  :vc (:url "https://github.com/syohex/emacs-helm-gtags2.git" :rev :newest)
  :config
  (setq-default helm-gtags2-pulse-at-cursor nil)

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
  :hook ((emacs-lisp-mode lisp-interaction-mode lisp-mode) . enable-paredit-mode))

(use-package git-gutter2
  :vc (:url "https://github.com/syohex/emacs-git-gutter2.git" :rev :newest)
  :config
  (global-git-gutter2-mode +1)

  (global-set-key (kbd "C-x v p") 'git-gutter2-popup-hunk)
  (global-set-key (kbd "C-x v u") 'git-gutter2-update)
  (global-set-key (kbd "C-x v r") 'git-gutter2-revert-hunk)
  (global-set-key (kbd "C-x v c") 'git-gutter2-clear-gutter)

  (global-set-key (kbd "C-x n") 'git-gutter2-next-hunk)
  (global-set-key (kbd "C-x p") 'git-gutter2-previous-hunk))

(use-package evil
  :config
  (setq-default evil-mode-line-format nil
                evil-symbol-word-search t)

  (evil-mode +1)
  (evil-set-toggle-key "M-z")

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

  (evil-set-leader nil (kbd "SPC"))
  (evil-define-key 'normal 'global (kbd "<leader>rr") #'anzu2-query-replace)
  (evil-define-key 'normal 'global (kbd "<leader>r%") #'anzu2-query-replace-at-cursor)
  (evil-define-key 'normal 'global (kbd "<leader>mf") #'mark-defun)
  (evil-define-key 'normal 'global (kbd "<leader>u") #'git-gutter2-update))

;; key mapping
(global-set-key [delete] #'delete-char)
(global-set-key (kbd "C-s") #'isearch-forward-regexp)
(global-set-key (kbd "C-r") #'isearch-backward-regexp)
(global-set-key (kbd "M-%") #'anzu2-query-replace-regexp)
(global-set-key (kbd "ESC M-%") #'anzu2-query-replace-at-cursor)
(global-set-key (kbd "C-x %") #'anzu2-replace-at-cursor-thing)
(global-set-key (kbd "C-M-c") #'duplicate-dwim)
(global-set-key (kbd "C-M-z") #'helm-resume)
(global-set-key (kbd "C-x !") #'eglot-rename)
(global-set-key (kbd "C-x m") #'eldoc-doc-buffer)
(global-set-key (kbd "C-x \\") #'eshell)
(global-set-key (kbd "C-x M-.") #'xref-find-references)
(global-set-key (kbd "C-x C-i") #'helm-imenu)
(global-set-key (kbd "C-x C-a") #'helm-M-x)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "C-x C-j") #'dired-jump)
(global-set-key (kbd "M-g .") #'helm-ag2)
(global-set-key (kbd "M-g ,") #'helm-ag2-pop-stack)
(global-set-key (kbd "M-g p") #'helm-ag2-project-root)
(global-set-key (kbd "M-g f") #'helm-do-ag2-project-root)
(global-set-key (kbd "C-M-y") #'helm-show-kill-ring)
(global-set-key (kbd "C-h a") #'helm-apropos)
