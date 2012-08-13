;; setting of auto-complete
(require 'popup)
(require 'fuzzy)
(require 'pos-tip)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/dot_files/emacs/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

(setq ac-auto-start nil)
(define-key ac-mode-map (kbd "M-/") 'auto-complete)

(setq ac-use-menu-map t)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map "\t" 'ac-complete)
(setq ac-quick-help-delay 0.5)
