;; setting of auto-complete
(require 'popup)
(require 'fuzzy)
;;(require 'pos-tip)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (concat user-emacs-directory "ac-dict"))
(global-auto-complete-mode t)
(ac-config-default)

;; Enable auto-complete mode other than default enable modes
(dolist (mode '(git-commit-mode
                coffee-mode
                go-mode
                markdown-mode
                fundamental-mode
                org-mode
                text-mode))
  (add-to-list 'ac-modes mode))

(custom-set-variables
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
  (case major-mode
    (ruby-mode (ac-complete-rsense))
    (python-mode (jedi:complete))
    (otherwise
     (if auto-complete-mode
         (auto-complete)
       (call-interactively 'dabbrev-expand)))))

;; ac-ispell
(ac-ispell-setup)

(dolist (hook '(text-mode-hook git-commit-mode-hook))
  (add-hook hook 'ac-ispell-ac-setup))
