;;;; redo+
;; (install-elisp-from-emacswiki "redo+.el")
(require 'redo+)
(global-set-key (kbd "C-`") 'undo)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
