;; Clojure
(with-eval-after-load 'cider
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'eldoc-mode)
  ;;(add-hook 'cider-mode-hook 'ac-cider-setup)
  ;;(add-hook 'cider-repl-mode-hook 'ac-cider-setup)

  (define-key cider-mode-map (kbd "C-M-i") 'company-complete)
  ;;(define-key cider-mode-map (kbd "C-M-i") 'company-complete)
  (define-key cider-mode-map (kbd "C-c C-q") nil))
