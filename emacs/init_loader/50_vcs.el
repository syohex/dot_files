;; for virsion control system
(global-auto-revert-mode 1)
(setq auto-revert-interval 10)
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; toggle-vc-mode
(setq max-specpdl-size 2000)
(setq max-lisp-eval-depth 1000)

;; disable vc-mode
(setq vc-handled-backends ())
