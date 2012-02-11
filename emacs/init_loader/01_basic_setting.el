;; Coloring
(global-font-lock-mode t)

;; temp directory
(when (system-linux-p)
  (setq temporary-file-directory "/mnt/ramdisk"))

;; cursor
(when window-system
    (set-cursor-color "chartreuse2")
    (setq blink-cursor-interval 0.5)
    (setq blink-cursor-delay 1.5)
    (blink-cursor-mode t))

;; for GC
(setq gc-cons-threshold (* gc-cons-threshold 10))

;; echo stroke
(setq echo-keystrokes 0.1)

;; large file
(setq large-file-warning-threshold (* 25 1024 1024))

;; saveplace
(savehist-mode 1)
(load "saveplace")
(setq-default save-place t)

;; case insensitive
(when (system-macosx-p)
  (setq case-fold-search t)
  (setq case-replace t))
(setq dabbrev-case-fold-search nil)

;; info for japanese
(auto-compression-mode t)

(transient-mark-mode t)

;; indicate last line
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

;; Disable scroll bar and tool bar
(when window-system
    (set-scroll-bar-mode 'nil)
    (tool-bar-mode 0))

;; not create backup file
(setq backup-inhibited t)

;; not create auto save file
(setq delete-auto-save-files t)

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

;; window間移動
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; naming of same name file
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; bm-mode
(when window-system
  (require 'bm nil t)
  (global-set-key (kbd "M-[") 'bm-previous)
  (global-set-key (kbd "M-]") 'bm-next)
  (set-face-background 'bm-face "DarkOrange1")
  (set-face-foreground 'bm-face "grey15")
  (set-face-bold-p 'bm-face t))

;; trump
(require 'tramp)
(setq tramp-shell-prompt-pattern "syohei@.*: *")

;; move physical line
(setq line-move-visual nil)

;; which-func
(require 'which-func)
(setq which-func-modes (append which-func-modes '(cperl-mode)))
(set-face-foreground 'which-func "chocolate4")
(set-face-bold-p 'which-func t)
(which-func-mode t)

;; auto-save
(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)

;; smartchr
(require 'smartchr)

;; invisible mouse cursor when editing text
(setq make-pointer-invisible t)

;; undo-tree
(require 'undo-tree)
(setq undo-tree-mode-lighter " UT")
(global-undo-tree-mode)

(define-key undo-tree-map (kbd "C-x u") 'undo-tree-undo)
(define-key undo-tree-map (kbd "C-/") 'undo-tree-visualize)

(defun kill-following-spaces ()
  (interactive)
  (let ((orig-point (point)))
    (save-excursion
      (if current-prefix-arg
          (skip-chars-backward " \t")
       (skip-chars-forward " \t"))
      (delete-region orig-point (point)))))

(global-set-key (kbd "M-k") 'kill-following-spaces)

(defun my/delete-indentation ()
  (interactive)
  (forward-line)
  (delete-indentation))
(global-set-key (kbd "M-K") 'my/delete-indentation)

;; show key bindings in current-mode with anything-interface
(require 'descbinds-anything)
(descbinds-anything-install)

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

;; expand symbolic link
(setq-default find-file-visit-truename t)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region)

;; indirect region
(require 'indirect-region)
