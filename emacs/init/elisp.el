;; setting for emacs-lisp

;;;; eldoc & slimenav
(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook 'eldoc-mode)
  (add-hook hook 'elisp-slime-nav-mode))

(custom-set-variables
 '(eldoc-idle-delay 0.2))

(setq-default edebug-inhibit-emacs-lisp-mode-bindings t)

(defun my/elisp-mode-hook ()
  (setq ac-sources
        (append '(ac-source-features ac-source-functions ac-source-variables ac-source-symbols) ac-sources)))
(add-hook 'emacs-lisp-mode-hook 'my/elisp-mode-hook)

;; Cask
(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))
