;;;; setting about `buffer'

;; auto-save
(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)

;; move other window
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; naming of same name file
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; use ibuffer instead of list-buffer
(defalias 'list-buffers 'ibuffer)

;; mark 'D'(delete) for matching buffer
(require 'ibuffer)
(defun ibuffer-menu-grep-delete (str)
  (interactive "sregexp: ")
  (save-excursion
    (goto-char (point-min))
    (forward-line 2)
    (while (re-search-forward str nil t)
      (save-excursion
        (ibuffer-mark-for-delete nil))
      (end-of-line))))

(define-key ibuffer-mode-map "R" 'ibuffer-menu-grep-delete)

;; based on http://ergoemacs.org/emacs/elisp_examples.html
(defvar my/cycle-buffer-limit 30)

(defun my/next-buffer ()
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i my/cycle-buffer-limit))
      (incf i)
      (next-buffer))))

(defun my/previous-buffer ()
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i my/cycle-buffer-limit))
      (incf i)
      (previous-buffer))))

(global-set-key (kbd "M-0") 'my/next-buffer)
(global-set-key (kbd "M-9") 'my/previous-buffer)
