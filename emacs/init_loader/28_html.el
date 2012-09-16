;; html-mode
(defun html-mode-insert-br ()
  (interactive)
  (insert "<br />"))

(defvar html-mode-map nil "keymap used in html-mode")
(if html-mode-map nil
    (setq html-mode-map (make-sparse-keymap))
    (define-key html-mode-map (kbd "C-c b") 'html-mode-insert-br))

;; zen-coding
(when (require 'zencoding-mode nil t)
  (add-hook 'sgml-mode-hook 'zencoding-mode)
  (add-hook 'html-mode-hook 'zencoding-mode))
