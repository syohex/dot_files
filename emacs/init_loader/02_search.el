;;;; setting for searching

(defun isearch-yank-symbol ()
  (interactive)
  (isearch-yank-internal (lambda () (forward-symbol 1) (point))))
(define-key isearch-mode-map (kbd "C-M-w") 'isearch-yank-symbol)

;; anzu
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))
(set-face-attribute 'anzu-mode-line nil
                    :foreground "yellow")
(set-face-attribute 'anzu-replace-to nil
                    :foreground "yellow" :background "grey10")
