;; encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(require 'cl)

;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; Add load path of emacs lisps
(add-to-list 'load-path "~/.emacs.d/elisps")

;; for editing config files
(require 'generic-x)

(delete-selection-mode t)

;; restore construction of windows
(winner-mode t)

(require 'thingopt)
(define-thing-commands)

;; for GC
(setq gc-cons-threshold (* gc-cons-threshold 10))

;; echo stroke
(setq echo-keystrokes 0.1)

;; large file
(setq large-file-warning-threshold (* 25 1024 1024))

;; isearch
(defun isearch-yank-symbol ()
  (interactive)
  (isearch-yank-internal (lambda () (forward-symbol 1) (point))))
(define-key isearch-mode-map (kbd "C-M-w") 'isearch-yank-symbol)

;; saveplace
(savehist-mode 1)
(load "saveplace")
(setq-default save-place t)

;; search
;; anzu
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-to-string-separator " => "))
(set-face-attribute 'anzu-mode-line nil
                    :foreground "yellow")
(set-face-attribute 'anzu-replace-to nil
                    :foreground "yellow" :background "grey10")

;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)

;; my key mapping
(global-set-key (kbd "M-C-o") 'other-window)
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "C-M-j") 'dabbrev-expand)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-M-s") 'helm-occur)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "M-g M-f") 'ffap)

(setq dabbrev-case-fold-search nil)

;; info for japanese
(auto-compression-mode t)

;; Coloring
(global-font-lock-mode t)

;; not highlight region
(transient-mark-mode nil)

;; indicate last line
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

;; not create backup file
(setq backup-inhibited t)

;; not create auto save file
(setq delete-auto-save-files t)

;; Disable menu bar
(menu-bar-mode -1)

;; show paren
(show-paren-mode 1)
(setq show-paren-delay 0
      show-paren-style 'expression)

;; kill buffer
(defun my/kill-buffer ()
  (interactive)
  (if (not current-prefix-arg)
      (call-interactively 'kill-buffer)
    (save-window-excursion
      (other-window 1)
      (let ((buf (current-buffer)))
        (when (y-or-n-p (format "kill buffer: %s" buf))
           (kill-buffer buf))))))
(global-set-key (kbd "C-x k") 'my/kill-buffer)

(defun kill-following-spaces ()
  (interactive)
  (let ((orig-point (point)))
    (save-excursion
      (skip-chars-forward " \t")
      (delete-region orig-point (point)))))
(global-set-key (kbd "M-k") 'kill-following-spaces)

;; not beep
(setq ring-bell-function (lambda()))

;; not display start message
(setq inhibit-startup-message t)

;; display line infomation
(line-number-mode 1)
(column-number-mode 1)

(defalias 'exit 'save-buffers-kill-emacs)

;; ignore upper or lower
(setq read-file-name-completion-ignore-case t)

;; Delete key
(global-set-key [delete] 'delete-char)

;; backspace
(normal-erase-is-backspace-mode 0)

;; smartparens
(custom-set-variables
 '(sp-highlight-pair-overlay nil)
 '(sp-highlight-wrap-overlay nil)
 '(sp-highlight-wrap-tag-overlay nil))

;; C coding style
(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (smartparens-mode +1)
  (sp-use-smartparens-bindings)
  (define-key c-mode-map (kbd "C-c o") 'ff-find-other-file)
  (c-toggle-electric-state -1)
  (setq c-basic-offset 8)
  (helm-gtags-mode))

(add-hook 'c-mode-hook 'my/c-mode-hook)

;; C++ coding style
(add-hook 'c++-mode-hook 'my/c-mode-hook)

;; asm-mode
(defun my/asm-mode-hook ()
  (helm-gtags-mode))

(add-hook 'asm-mode-hook 'my/asm-mode-hook)

;; ibuffer
(defalias 'list-buffers 'ibuffer)

;; mark 'D'(delete) for matching buffer
(defun ibuffer-menu-grep-delete (str)
  (interactive "sregexp: ")
  (save-excursion
    (goto-char (point-min))
    (forward-line 2)
    (while (re-search-forward str nil t)
      (save-excursion
        (ibuffer-mark-for-delete nil))
      (end-of-line))))

(eval-after-load "ibuffer"
  '(progn
     (define-key ibuffer-mode-map "R" 'ibuffer-menu-grep-delete)))

;; undo tree
(setq undo-no-redo t
      undo-limit 600000
      undo-strong-limit 900000)

;;;; dired
(require 'dired)
;; Not create new buffer, if you chenge directory in dired
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
;; display directories by first
(when (executable-find "gls")
  (setq insert-directory-program "gls"))
(load-library "ls-lisp")
(setq ls-lisp-dirs-first t)
;; recursive copy, remove
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; dired-x
(load "dired-x")

;; wdired
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; helm
(require 'helm-config)

(eval-after-load "helm"
  '(progn
     (define-key helm-map (kbd "C-q") 'helm-execute-persistent-action)
     (setq helm-idle-delay 0.1)
     (setq helm-input-idle-delay 0)
     (setq helm-candidate-number-limit 500)))

(eval-after-load "helm-ag"
  '(progn
     (setq helm-ag-insert-at-point 'symbol)))

(require 'helm-descbinds)
(helm-descbinds-install)

;; gtags
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "C-t") 'helm-gtags-pop-stack)))

;; ack
(setq helm-c-ack-insert-at-point 'symbol)

;; helm in dired
(setq-default split-width-threshold 0)

(define-key helm-map (kbd "C-p") 'helm-previous-line)
(define-key helm-map (kbd "C-n") 'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

;; helm-show-kill-ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; apropos with helm and man
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-h m") 'helm-man-woman)

;; helm faces
(require 'helm-files)
(set-face-background 'helm-selection "pink")
(set-face-foreground 'helm-selection "black")
(set-face-foreground 'helm-ff-file "white")
(set-face-bold-p 'helm-ff-file nil)
(set-face-foreground 'helm-ff-directory "cyan")
(set-face-background 'helm-ff-directory nil)

(set-face-foreground 'highlight nil)
(set-face-background 'highlight "green")
(set-face-underline-p 'highlight t)

;; naming of same name file
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; recentf-ext
(recentf-mode 1)
(setq recentf-max-saved-items 1000
      recentf-save-file "~/.recentf-kernel")
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(run-at-time t 600 'recentf-save-list)
(setq recentf-exclude '("/auto-install/" ".recentf" "/repos/" "/elpa/"
                        "\\.mime-example" "\\.ido.last"))

;; for virsion control system
(global-auto-revert-mode 1)
(setq auto-revert-interval 10
      vc-follow-symlinks t
      auto-revert-check-vc-info t)

;; disable vc-mode
(setq vc-handled-backends '())

;; which-func
(require 'which-func)
(setq which-func-modes (append which-func-modes '(cperl-mode)))
(set-face-foreground 'which-func "chocolate4")
(set-face-bold-p 'which-func t)
(which-func-mode t)

;; view-mode
(setq view-read-only t)

;; for regexp color
(set-face-foreground 'font-lock-regexp-grouping-backslash "#ff1493")
(set-face-foreground 'font-lock-regexp-grouping-construct "#ff8c00")

;; move physical line
(setq line-move-visual nil)

;; popwin
(require 'popwin)
(defvar popwin:special-display-config-backup popwin:special-display-config)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      (append '(("*Apropos*") ("*sdic*") ("*Faces*") ("*Colors*"))
              popwin:special-display-config))

;; use popwin
(push '(Man-mode :stick t :height 20) popwin:special-display-config)
(push '("*sgit*" :width 0.5 :position right :stick t) popwin:special-display-config)

;; fixed line position after scrollup, scrolldown
(defadvice scroll-up (around scroll-up-relative activate)
  "Scroll up relatively without move of cursor."
  (let ((orig-line (count-lines (window-start) (point))))
    ad-do-it
    (move-to-window-line orig-line)))

(defadvice scroll-down (around scroll-down-relative activate)
  "Scroll down relatively without move of cursor."
  (let ((orig-line (count-lines (window-start) (point))))
    ad-do-it
    (move-to-window-line orig-line)))

;; for symboliclink
(setq-default find-file-visit-truename t)

;; (makunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  "Most superior minir mode"
  t  ;; default is enable
  "" ;; Not display mode-line
  `((,(kbd "C-M-j") . dabbrev-expand)
    (,(kbd "M-q") . ace-jump-word-mode)
    (,(kbd "M-C-o") . other-window)))

(defvar my/alt-q-map (make-sparse-keymap)
  "My original keymap binded to M-q.")
(defalias 'my/alt-q-prefix my/alt-q-map)
(define-key overriding-minor-mode-map (kbd "M-q") 'my/alt-q-prefix)

;; ace-jump-mode
(eval-after-load "ace-jump-mode"
  '(progn
     (set-face-foreground 'ace-jump-face-foreground "green")
     (set-face-bold-p 'ace-jump-face-foreground t)
     (set-face-underline-p 'ace-jump-face-foreground t)
     (set-face-foreground 'ace-jump-face-background "grey40")))

;; switch next/previous buffer
(global-set-key (kbd "M-9") 'bs-cycle-next)
(global-set-key (kbd "M-0") 'bs-cycle-previous)

;; scroll bar
(require 'yascroll)
(global-yascroll-bar-mode t)
(setq yascroll:disabled-modes
      '(completing-list-mode))

;; smartrep
(require 'smartrep)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)
(define-key my/ctrl-q-map (kbd "|") 'winner-undo)
(define-key my/ctrl-q-map (kbd "C-b") 'helm-bookmarks)
(define-key my/ctrl-q-map (kbd "l") 'copy-line)
(define-key my/ctrl-q-map (kbd "k") 'kill-whole-line)

;; goto-chg
(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

;; sgit
(require 'sgit)
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v s") 'sgit:status)
(global-set-key (kbd "C-x v l") 'sgit:log)

;; magit
(global-set-key (kbd "M-g M-g") 'magit-status)

;; auto-complete
(require 'popup)
(require 'fuzzy)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)

;; other modes to be enable auto-complete
(add-to-list 'ac-modes 'git-commit-mode)

(setq ac-auto-start nil)
(setq ac-use-menu-map t)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map (kbd "C-i") 'ac-complete)

(setq ac-quick-help-delay 0.5)
(global-set-key (kbd "C-M-i") 'auto-complete)

;; eshell
(eval-after-load "em-prompt"
  '(progn
     (set-face-attribute 'eshell-prompt nil
                         :foreground "yellow")))

(eval-after-load "esh-mode"
  '(progn
     (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)))

(defvar eshell-pop-buffer "*eshell-pop*")
(defvar eshell-prev-buffer nil)

(defun eshell-pop ()
  (interactive)
  (setq eshell-prev-buffer (current-buffer))
  (unless (get-buffer eshell-pop-buffer)
    (save-window-excursion
      (pop-to-buffer (get-buffer-create eshell-pop-buffer))
      (eshell-mode)))
  (popwin:popup-buffer (get-buffer eshell-pop-buffer)
                       :height 20 :stick t))
(global-set-key (kbd "M-g M-s") 'eshell-pop)

(defun eshell/cde ()
  (let* ((file-name (buffer-file-name eshell-prev-buffer))
         (dir (or (and file-name (file-name-directory file-name))
                  (and (eq major-mode 'dired-mode) dired-directory)
                  (with-current-buffer eshell-prev-buffer
                    default-directory))))
    (eshell/cd dir)))

(defun eshell/cdp ()
  (let* ((cmd "git rev-parse --show-toplevel")
         (dir (with-temp-buffer
                (unless (call-process-shell-command cmd nil t)
                  (error "Here is not Git Repository"))
                (goto-char (point-min))
                (buffer-substring-no-properties
                 (point) (line-end-position)))))
    (eshell/cd dir)))

(global-set-key (kbd "M-g M-i") 'import-popwin)

(require 'editutil)
(global-set-key [(control shift up)] 'editutil-move-line-up)
(global-set-key [(control shift down)] 'editutil-move-line-down)

(global-set-key (kbd "C-M-s") 'editutil-forward-char)
(global-set-key (kbd "C-M-r") 'editutil-backward-char)

(global-set-key (kbd "M-o") 'editutil-edit-next-line)
(global-set-key (kbd "M-O") 'editutil-edit-previous-line)

(global-set-key (kbd "M-s") 'editutil-unwrap-at-point)
(global-set-key (kbd "M-r") 'editutil-replace-wrapped-string)
(global-set-key (kbd "M-z") 'editutil-zap-to-char)

(global-set-key (kbd "M-n") 'editutil-next-symbol)
(global-set-key (kbd "M-p") 'editutil-previous-symbol)

(global-set-key (kbd "M-k") 'editutil-delete-following-spaces)

(global-set-key (kbd "C-y") 'editutil-yank)

(global-set-key (kbd "M-d") 'editutil-delete-word)
(global-set-key (kbd "M-<backspace>") 'editutil-backward-delete-word)

(global-set-key (kbd "C-x r N") 'editutil-number-rectangle)

(global-set-key (kbd "C-M-SPC") 'editutil-copy-sexp)

(smartrep-define-key
    global-map "C-x" '(("j" . 'editutil-insert-newline-without-moving)))

(smartrep-define-key
    global-map "M-g" '(("c" . 'editutil-duplicate-thing)))

(eval-after-load "diff-mode"
  '(progn
     (set-face-attribute 'diff-added nil
                         :background nil :foreground "green"
                         :weight 'normal)
     (set-face-attribute 'diff-removed nil
                         :background nil :foreground "red"
                         :weight 'normal)

     (set-face-attribute 'diff-refine-change nil
                         :background nil :foreground "yellow"
                         :weight 'normal)

     (set-face-attribute 'diff-file-header nil
                         :foreground "white"
                         :background nil :weight 'extra-bold)

     (set-face-attribute 'diff-function nil
                         :foreground "cyan"
                         :background nil
                         :underline nil)

     (set-face-attribute 'diff-header nil
                         :background nil
                         :underline nil)

     (set-face-attribute 'diff-hunk-header nil
                         :foreground "yellow"
                         :background nil
                         :weight 'bold
                         :underline t)))

(progn
  (set-face-attribute 'show-paren-match nil
		      :background nil :foreground nil
		      :underline t :weight 'bold))
