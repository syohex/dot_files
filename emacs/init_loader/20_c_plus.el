;; C++ coding style
(defun my/c++-mode-init ()
  (c-set-style "k&r")
  (define-key c++-mode-map (kbd "C-c o") 'ff-find-other-file)
  (c-toggle-electric-state -1)
  (hs-minor-mode 1)
  (my/wrap-region-as-autopair)
  (setq c-basic-offset 4)
  (my/setup-symbol-moving))

(add-hook 'c++-mode-hook #'my/c++-mode-init)
