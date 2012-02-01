;; setting of auto-complete
(require 'pos-tip)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/repos/auto-complete/dict")
(ac-config-default)

(setq ac-auto-start nil)
(define-key ac-mode-map (kbd "M-/") 'auto-complete)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-completing-map "\t" 'ac-complete)
(setq ac-quick-help-delay 0.5)
