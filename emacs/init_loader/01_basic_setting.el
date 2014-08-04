(require 'cl-lib)

;; encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

;; Coloring
(global-font-lock-mode +1)

;; mode-line color
(set-face-attribute 'mode-line nil
                    :background "#333333" :foreground "#cccccd")
(set-face-attribute 'mode-line-buffer-id nil
                    :foreground "orange" :weight 'bold)

;; basic customize variables
(custom-set-variables
 '(large-file-warning-threshold (* 25 1024 1024))
 '(save-place t)
 '(dabbrev-case-fold-search nil)
 '(inhibit-startup-screen t)
 '(x-select-enable-clipboard t)
 '(read-file-name-completion-ignore-case t)
 '(line-move-visual nil)
 '(set-mark-command-repeat-pop t)
 '(find-file-visit-truename t)
 '(horizontal-scroll-bar nil)
 '(compile-command ""))

;; temp directory
(when (file-exists-p "/mnt/ramdisk")
  (setq temporary-file-directory "/mnt/ramdisk/"))

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

;; enable yascrollbar
(global-yascroll-bar-mode)
(custom-set-variables
 '(yascroll:disabled-modes
   '(eshell-mode magit-status-mode completion-list-mode compilation-mode)))

;; not create backup file and not create auto save file
(setq backup-inhibited t
      delete-auto-save-files t)

;; Disable menu bar
(menu-bar-mode -1)

;; not beep
(setq ring-bell-function (lambda()))

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
(require 'which-func)
(set-face-attribute 'which-func nil
                    :foreground "LightPink3" :weight 'bold)
(which-function-mode +1)

;; invisible mouse cursor when editing text
(setq make-pointer-invisible t)

;; undo setting
(setq undo-no-redo t
      undo-limit 600000
      undo-strong-limit 900000)

;;;; undo-tree
(global-undo-tree-mode)
(define-key undo-tree-map (kbd "C-x u") 'undo-tree-undo)
(define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)
(global-set-key (kbd "M-/") 'undo-tree-redo)

;; fill-mode
(setq fill-column 80)

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

;; smart repetition
(require 'smartrep)
(custom-set-variables
 '(smartrep-mode-line-active-bg nil)
 '(smartrep-mode-line-string-activated "<<< SmartRep >>>"))

;; comint
(eval-after-load "comint"
  '(set-face-attribute 'comint-highlight-input nil
                       :foreground "grey80" :weight 'semi-bold))

;; specify mode
(add-to-list 'auto-mode-alist '("/Changes\\'" . text-mode))
