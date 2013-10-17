;;;; C and C++ setting

(eval-after-load "cc-mode"
  '(progn
     ;; key bindings
     (define-key c-mode-map (kbd "C-c o") 'ff-find-other-file)
     (define-key c-mode-map (kbd "C-c C-s") 'my/unwrap-at-point)

     (require 'ac-c-headers)))

(defun my/c-mode-init ()
  (c-set-style "k&r")
  (c-toggle-electric-state -1)
  (my/setup-symbol-moving)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-header-symbols t)
  (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'my/c-mode-init)
