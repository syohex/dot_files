;; setting for emacs-lisp
(find-function-setup-keys)

;;;; eldoc & slimenav
(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook 'eldoc-mode)
  (add-hook hook 'elisp-slime-nav-mode))

(custom-set-variables
 '(eldoc-idle-delay 0.2))

;; Cask
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))
