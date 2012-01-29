;; C++ coding style
(defun my/c++-mode-init ()
  (c-set-style "k&r")
  (define-key c++-mode-map (kbd "C-c o") 'ff-find-other-file)
  (c-toggle-electric-state -1)
  (hs-minor-mode 1)
  (setq c-basic-offset 4)
  ;; for auto-complete using clang
  (require 'auto-complete-clang)
  (ac-clang-set-prefix-header "~/dot_files/emacs/stdafx_cpp.pch")
  (push ac-source-clang ac-sources))

(add-hook 'c++-mode-hook #'my/c++-mode-init)
