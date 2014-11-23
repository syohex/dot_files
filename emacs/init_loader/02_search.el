;;;; setting for searching
(define-key isearch-mode-map (kbd "C-M-s") 'isearch-forward-symbol-at-point)

(with-eval-after-load 'ace-jump-mode
  (setq ace-jump-mode-case-fold nil))

;; anzu
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-to-string-separator " => "))
