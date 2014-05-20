;; setting of auto-complete
(ac-config-default)

;; Enable auto-complete mode other than default enable modes
(dolist (mode '(git-commit-mode
                coffee-mode
                go-mode
                cider-repl-mode
                markdown-mode
                fundamental-mode
                org-mode
                text-mode))
  (add-to-list 'ac-modes mode))

(custom-set-variables
 `(ac-dictionary-directories ,(concat user-emacs-directory "ac-dict"))
 '(ac-use-fuzzy t)
 '(ac-auto-start nil)
 '(ac-use-menu-map t)
 '(ac-quick-help-delay 1.0))

(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map (kbd "<tab>") 'ac-complete)

;; for global minor mode
(defun my/auto-complete ()
  (interactive)
  (cl-case major-mode
    (python-mode (jedi:complete))
    (otherwise
     (if auto-complete-mode
         (call-interactively 'auto-complete)
       (call-interactively 'dabbrev-expand)))))

;; ac-ispell
(ac-ispell-setup)

(dolist (hook '(text-mode-hook markdown-mode-hook))
  (add-hook hook 'ac-ispell-ac-setup))
