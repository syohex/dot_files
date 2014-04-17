;; Clojure
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)

(eval-after-load "cider"
  '(progn
     (define-key cider-mode-map (kbd "C-M-i") 'auto-complete)))
