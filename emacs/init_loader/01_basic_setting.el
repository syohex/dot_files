;; encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

;; Coloring
(global-font-lock-mode t)

;; temp directory
(when (file-exists-p "/mnt/ramdisk")
  (setq temporary-file-directory "/mnt/ramdisk/"))

;; default frame size
(when (and window-system (not (macosx-p)))
  (setq default-frame-alist
        '((width . 115) (height . 42) (top . 28) (left . 0))))

;; cursor
(when window-system
  (set-cursor-color "chartreuse2")
  (blink-cursor-mode t))

;; for GC
(setq gc-cons-threshold (* gc-cons-threshold 10))

;; echo stroke
(setq echo-keystrokes 0.1)

;; large file
(setq large-file-warning-threshold (* 25 1024 1024))

;; I never use C-x C-c
(defalias 'exit 'save-buffers-kill-emacs)

;; enable narrow-to-region
(put 'narrow-to-region 'disabled nil)

;; saveplace
(savehist-mode 1)
(load "saveplace")
(setq-default save-place t)

(setq dabbrev-case-fold-search nil)

;; info for japanese
(auto-compression-mode t)

;; highlight mark region
(transient-mark-mode t)

;; indicate last line
(setq-default indicate-empty-lines t
              indicate-buffer-boundaries 'right)

;; Disable default scroll bar and tool bar
(when window-system
  (set-scroll-bar-mode 'nil)
  (tool-bar-mode 0))

;; enable yascrollbar
(global-yascroll-bar-mode)
(setq yascroll:disabled-modes
      '(eshell-mode magit-status-mode completion-list-mode compilation-mode))

;; not create backup file and not create auto save file
(setq backup-inhibited t
      delete-auto-save-files t)

;; Disable menu bar
(menu-bar-mode -1)

;; not beep
(setq ring-bell-function (lambda()))

;; not display start message
(setq inhibit-startup-message t)

;; display line infomation
(line-number-mode 1)
(column-number-mode 1)

;; to send clip board
(setq x-select-enable-clipboard t)

;; ignore upper or lower
(setq read-file-name-completion-ignore-case t)

;; yes-or-no-p
(defalias 'yes-or-no-p 'y-or-n-p)

;; move physical line
(setq line-move-visual nil)

;; which-func
(require 'which-func)
(set-face-attribute 'which-func nil
                    :foreground "LightPink3" :weight 'bold)
(which-func-mode t)

;; invisible mouse cursor when editing text
(setq make-pointer-invisible t)

;; undo setting
(setq undo-no-redo t
      undo-limit 600000
      undo-strong-limit 900000)

;;;; undo-tree
(global-undo-tree-mode)
(define-key undo-tree-map (kbd "C-x u") 'undo-tree-undo)
(define-key undo-tree-map (kbd "C-/") 'undo-tree-visualize)

;; fill-mode
(setq fill-column 80)

;; move to mark position
(setq set-mark-command-repeat-pop t)

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
(setq smartrep-mode-line-active-bg nil
      smartrep-mode-line-string-activated "<<< SmartRep >>>")

;; expand symbolic link
(setq-default find-file-visit-truename t)

;; for popular file type
(require 'generic-x)

;; compile
(custom-set-variables
 '(compile-command ""))

;; comint
(eval-after-load "comint"
  '(progn
     (set-face-attribute 'comint-highlight-input nil
                         :foreground "DarkOrange1" :weight 'semi-bold)))

;; ido
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-max-prospects 8
      ido-default-file-method 'selected-window
      ido-auto-merge-work-directories-length -1)
(global-set-key (kbd "C-x C-p") 'ido-find-file)
(define-key minibuffer-local-map (kbd "C-h") 'backward-delete-char)

(set-face-attribute 'ido-first-match nil
                    :foreground "orange" :weight 'semi-bold)
(set-face-attribute 'ido-only-match nil
                    :foreground "orange" :weight 'semi-bold)
(set-face-attribute 'ido-subdir nil
                    :foreground "cyan" :weight 'semi-bold)
