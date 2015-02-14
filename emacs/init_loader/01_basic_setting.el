(require 'cl-lib)

;; encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

;; Coloring
(global-font-lock-mode +1)

;; basic customize variables
(custom-set-variables
 '(large-file-warning-threshold (* 25 1024 1024))
 '(save-place t)
 '(dabbrev-case-fold-search nil)
 '(inhibit-startup-screen t)
 '(read-file-name-completion-ignore-case t)
 '(line-move-visual nil)
 '(set-mark-command-repeat-pop t)
 '(find-file-visit-truename t)
 '(comment-style 'multi-line)
 '(imenu-auto-rescan t)
 '(delete-auto-save-files t)
 '(create-lockfiles nil)
 '(backup-directory-alist `((".*" . ,temporary-file-directory)))
 '(auto-save-file-name-transforms `((".*" ,temporary-file-directory t))))

(setq-default horizontal-scroll-bar nil)

;; temp directory
(when (file-exists-p "/mnt/ramdisk")
  (setq-default temporary-file-directory "/mnt/ramdisk/"))

;; cursor
(set-cursor-color "chartreuse2")
(blink-cursor-mode t)

;; for GC
(setq gc-cons-threshold (* gc-cons-threshold 10))

;; echo stroke
(setq echo-keystrokes 0.1)
;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)

;; enable narrow-to-region
(put 'narrow-to-region 'disabled nil)

;; saveplace
(savehist-mode 1)
(load "saveplace")

;; info for japanese
(auto-compression-mode t)

;; highlight mark region
(transient-mark-mode +1)

;; indicate last line
(setq-default indicate-empty-lines t
              indicate-buffer-boundaries 'right)

;; Disable default scroll bar and tool bar
(when window-system
  (set-scroll-bar-mode 'nil)
  (tool-bar-mode 0))

;; not create backup file and not create auto save file
(setq backup-inhibited t)

;; Disable menu bar
(menu-bar-mode -1)

;; not beep
(setq ring-bell-function 'ignore)

;; display line infomation
(line-number-mode 1)
(column-number-mode 1)

;; yes-or-no-p
(defalias 'yes-or-no-p 'y-or-n-p)
(setq use-dialog-box nil)

;; history
(setq history-length 500
      history-delete-duplicates t)

;; run server
(require 'server)
(unless (server-running-p)
  (server-start))

;; which-func
(which-function-mode +1)
(setq-default which-func-unknown "")

;; invisible mouse cursor when editing text
(setq make-pointer-invisible t)

;; undo setting
(setq undo-no-redo t
      undo-limit 600000
      undo-strong-limit 900000)

;;;; undo-tree
(global-undo-tree-mode)
(define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)
(define-key undo-tree-map (kbd "M-_") 'nil)

;; fill-mode
(setq fill-column 80)

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

;; for Changes
(add-to-list 'auto-mode-alist '("/Changes\\'" . text-mode))

(defun my/text-mode-hook ()
  (when (string-match-p "\\`Changes" (buffer-name))
    (flyspell-mode +1)))
(add-hook 'text-mode-hook 'my/text-mode-hook)
