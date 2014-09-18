(with-eval-after-load 'tuareg
  (define-key tuareg-mode-map (kbd "C-c C-z") 'tuareg-run-ocaml)
  (define-key tuareg-mode-map (kbd "M-o") 'editutil-edit-next-line-same-column))
