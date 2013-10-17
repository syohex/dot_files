;;;; C and C++ setting
;; C coding style
(defun my/c-mode-init ()
  (c-set-style "k&r")
  (c-toggle-electric-state -1)
  (define-key c-mode-map (kbd "C-c o") 'ff-find-other-file)
  (define-key c-mode-map (kbd "C-c C-s") 'my/unwrap-at-point)
  (hs-minor-mode 1)
  (my/setup-symbol-moving)
  (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'my/c-mode-init)
