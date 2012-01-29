;; ibuffer
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
