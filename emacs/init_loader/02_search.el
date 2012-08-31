;;;; setting for searching

(defun isearch-yank-symbol ()
  (interactive)
  (isearch-yank-internal (lambda () (forward-symbol 1) (point))))

(define-key isearch-mode-map (kbd "C-M-w") 'isearch-yank-symbol)

;; setting migemo
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)

(load "migemo" 'noerror)
(eval-after-load "migemo"
    '(progn
       (migemo-init)
       (setq migemo-isearch-enable-p nil)))

(defadvice isearch-done (after migemo-search-ad activate)
  "Disable migemo"
  (if migemo-isearch-enable-p
      (setq migemo-isearch-enable-p nil)))
