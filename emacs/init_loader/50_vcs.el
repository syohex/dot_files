;;;; Common VCS setting
(global-auto-revert-mode 1)
(setq auto-revert-interval 10)
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; disable vc-mode
(setq vc-handled-backends '())

;;; git

;; git-commit-mode
(autoload 'git-commit-mode "git-commit" nil t)

(eval-after-load "git-commit"
  '(progn
     (add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . git-commit-mode))
     (add-hook 'git-commit-mode-hook 'flyspell-mode)
     (set-face-foreground 'git-commit-summary-face nil)
     (set-face-underline  'git-commit-summary-face t)
     (set-face-foreground 'git-commit-nonempty-second-line-face nil)
     (set-face-bold-p     'git-commit-nonempty-second-line-face nil)))
