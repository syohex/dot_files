;;;; Common VCS setting
(global-auto-revert-mode 1)
(setq auto-revert-interval 10)
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; disable vc-mode
(setq vc-handled-backends '())

;;; Setting for Git
;; sgit
(require 'sgit)
(global-set-key (kbd "C-x v l") 'sgit:log)
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v s") 'sgit:status)

;; git-commit-mode
(autoload 'git-commit-mode "git-commit" nil t)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . git-commit-mode))

(eval-after-load "git-commit"
  '(progn
     (add-to-list 'ac-sources 'ac-source-look)
     (add-hook 'git-commit-mode-hook 'flyspell-mode)
     (set-face-foreground 'git-commit-summary-face nil)
     (set-face-underline  'git-commit-summary-face t)
     (set-face-foreground 'git-commit-nonempty-second-line-face nil)
     (set-face-bold-p     'git-commit-nonempty-second-line-face nil)))

;; git-gutter
(global-set-key (kbd "C-x v g") 'git-gutter)
(eval-after-load "git-gutter"
  '(progn
     (setq git-gutter:modified-sign " ")
     (set-face-background 'git-gutter:modified "purple")))
