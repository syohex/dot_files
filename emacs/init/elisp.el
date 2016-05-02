;; setting for emacs-lisp
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

;;;; eldoc & slimenav
(dolist (hook '(emacs-lisp-mode-hook
                ielm-mode-hook))
  (add-hook hook 'eldoc-mode)
  (add-hook hook 'elisp-slime-nav-mode))

(custom-set-variables
 '(eldoc-idle-delay 0.2))

(setq-default edebug-inhibit-emacs-lisp-mode-bindings t)

(defun my/elisp-mode-hook ()
  ;;(setq ac-sources '(ac-source-features ac-source-functions ac-source-variables))
  (setq-local company-backends '((company-dabbrev-code company-keywords) company-dabbrev)))

(add-hook 'emacs-lisp-mode-hook 'my/elisp-mode-hook)
