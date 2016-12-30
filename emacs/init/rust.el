(custom-set-variables
 '(rust-format-on-save nil))

(with-eval-after-load 'rust-mode
  (flycheck-rust-setup)

  (define-key rust-mode-map (kbd "C-c C-s") 'rust-format-buffer))

(add-hook 'rust-mode-hook 'racer-mode)
(add-hook 'racer-mode-hook 'eldoc-mode)
