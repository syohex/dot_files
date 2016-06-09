;; basic configurations
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(global-font-lock-mode +1)

;; basic customize variables
(custom-set-variables
 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
 '(backup-directory-alist `((".*" . ,temporary-file-directory)))
 '(comment-style 'extra-line)
 '(create-lockfiles nil)
 '(dabbrev-case-fold-search nil)
 '(delete-auto-save-files t)
 '(find-file-visit-truename t)
 '(imenu-auto-rescan t)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold (* 25 1024 1024))
 '(package-enable-at-startup nil)
 '(read-file-name-completion-ignore-case t)
 '(set-mark-command-repeat-pop t)
 '(text-quoting-style 'grave)
 '(user-full-name "Syohei YOSHIDA"))

(setq-default horizontal-scroll-bar nil)

;; cursor
(blink-cursor-mode t)

;; for GC
(setq-default gc-cons-threshold (* gc-cons-threshold 10))

(setq-default echo-keystrokes 0)
;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)

;; Don't disable commands
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(savehist-mode 1)
(save-place-mode +1)

;; info for japanese
(auto-compression-mode t)

;; indicate last line
(setq-default indicate-empty-lines t
              indicate-buffer-boundaries 'right)

;; Disable default scroll bar and tool bar
(when window-system
  (set-scroll-bar-mode 'nil)
  (tool-bar-mode 0))

;; not create backup file and not create auto save file
(setq-default backup-inhibited t)

(menu-bar-mode -1)

;; not beep
(setq-default ring-bell-function #'ignore)

;; display line infomation
(line-number-mode 1)
(column-number-mode 1)

(fset 'yes-or-no-p #'y-or-n-p)
(setq-default use-dialog-box nil)

(setq-default history-length 500
              history-delete-duplicates t)

(require 'server)
(unless (server-running-p)
  (server-start))

;; which-func
(which-function-mode +1)
(setq-default which-func-unknown "")

;; invisible mouse cursor when editing text
(setq-default make-pointer-invisible t)

;; undo setting
(setq-default undo-no-redo t
              undo-limit 600000
              undo-strong-limit 900000)

;;;; undo-tree
(global-undo-tree-mode)
(define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)
(define-key undo-tree-map (kbd "M-_") 'nil)

(setq-default fill-column 80)

;; fixed line position after scrollup, scrolldown
(defun my/scroll-move-around (orig-fn &rest args)
  (let ((orig-line (count-lines (window-start) (point))))
    (apply orig-fn args)
    (move-to-window-line orig-line)))
(advice-add 'scroll-up :around 'my/scroll-move-around)
(advice-add 'scroll-down :around 'my/scroll-move-around)

;; smart repetition
(require 'smartrep)
(custom-set-variables
 '(smartrep-mode-line-active-bg nil)
 '(smartrep-mode-line-string-activated "<<< SmartRep >>>"))

(add-to-list 'auto-mode-alist '("/\\(?:LICENSE\\|Changes\\)\\'" . text-mode))

(defun my/text-mode-hook ()
  (when (string-prefix-p "Changes" (buffer-name))
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
