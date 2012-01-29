;; C coding style
(defun my/c-mode-init ()
  (c-set-style "k&r")
  (c-toggle-electric-state -1)
  (define-key c-mode-map (kbd "C-c o") 'ff-find-other-file)
  (hs-minor-mode 1)
  (if window-system
      (setq c-basic-offset 4)
    (setq c-basic-offset 8)))

(add-hook 'c-mode-hook #'my/c-mode-init)
