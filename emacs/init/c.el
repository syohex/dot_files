;;;; C and C++ and assembly language setting

(with-eval-after-load 'cc-mode
  ;; key bindings
  (define-key c-mode-map (kbd "C-c C-t") 'ff-find-other-file)
;;  (require 'ac-c-headers)
  )

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (setq indent-tabs-mode t
        c-basic-offset 8)
  (c-toggle-electric-state -1)
;;  (add-to-list 'ac-sources 'ac-source-c-headers)
;;  (add-to-list 'ac-sources 'ac-source-c-header-symbols t)
  )

(add-hook 'c-mode-hook 'my/c-mode-hook)
(add-hook 'c++-mode-hook 'my/c-mode-hook)

(with-eval-after-load 'asm-mode
  (define-key asm-mode-map (kbd "RET") 'newline))
