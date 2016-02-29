(custom-set-variables
 '(cider-prompt-save-file-on-load 'always-save)
 '(cider-font-lock-dynamically '(macro core function var))
 '(nrepl-hide-special-buffers t))

(with-eval-after-load 'cider
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'eldoc-mode)
  ;;(add-hook 'cider-mode-hook 'ac-cider-setup)
  ;;(add-hook 'cider-repl-mode-hook 'ac-cider-setup)

  (define-key cider-mode-map (kbd "C-M-i") 'company-complete)
  (define-key cider-mode-map (kbd "C-c C-q") nil))

(with-eval-after-load 'clj-refactor
  (cljr-add-keybindings-with-prefix "C-c C-m"))
