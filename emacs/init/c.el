;;;; C and C++ and assembly language setting

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (setq indent-tabs-mode t
        c-basic-offset 8)
  (c-toggle-electric-state -1)
  (setq-local company-backends '(company-clang company-dabbrev)))

(add-hook 'c-mode-hook #'my/c-mode-hook)
(add-hook 'c++-mode-hook #'my/c-mode-hook)

(defun my/objc-mode-hook ()
  (setq c-basic-offset 4)
  (c-toggle-electric-state -1)
  (setq-local company-backends '(company-clang company-dabbrev)))

(add-hook 'objc-mode-hook #'my/objc-mode-hook)
(add-to-list 'auto-mode-alist '("\\.mm\\'" . c++-mode))

(with-eval-after-load 'c-mode
  (define-key c-mode-base-map (kbd "C-c o") #'ff-find-other-file)
  (define-key c-mode-base-map (kbd "C-c C-s") #'clang-format-buffer))

(with-eval-after-load 'asm-mode
  (define-key asm-mode-map (kbd "RET") 'newline))
