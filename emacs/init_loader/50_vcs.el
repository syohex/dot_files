;; for virsion control system
(global-auto-revert-mode 1)
(setq auto-revert-interval 10)
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; toggle-vc-mode
(setq max-specpdl-size 2000)
(setq max-lisp-eval-depth 1000)
(require 'cl)
(setq toggle-vc-list '(Git SVN CVS))
(defun toggle-vc-mode ()
  "toggle vc-mode"
  (interactive)
  (if (intersection vc-handled-backends toggle-vc-list)
      (setq vc-handled-backends (set-difference vc-handled-backends toggle-vc-list))
    (setq vc-handled-backends (union vc-handled-backends toggle-vc-list))))

(toggle-vc-mode) ;; Default vc-mode is turned off
