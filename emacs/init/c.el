;;;; C and C++ and assembly language setting

(defun my/c-mode-hook ()
  (eglot-ensure)
  (c-set-style "k&r")
  (setq indent-tabs-mode t
        c-basic-offset 8)
  (c-toggle-electric-state -1))

(add-hook 'c-mode-hook #'my/c-mode-hook)
(add-hook 'c++-mode-hook #'my/c-mode-hook)

(with-eval-after-load 'c-mode
  (define-key c-mode-base-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c-mode-base-map (kbd "C-c C-s") #'clang-format-buffer))

(with-eval-after-load 'c++-mode
  (define-key c++-mode-map (kbd "C-c o") #'ff-find-other-file))

(with-eval-after-load 'asm-mode
  (define-key asm-mode-map (kbd "RET") 'newline))
