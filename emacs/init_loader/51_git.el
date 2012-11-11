;;;; git-commit-mode
(autoload 'git-commit-mode "git-commit" nil t)

(eval-after-load "git-commit"
  '(progn
     (set-face-foreground 'git-commit-summary-face nil)
     (set-face-underline  'git-commit-summary-face t)
     (set-face-foreground 'git-commit-nonempty-second-line-face nil)
     (set-face-bold-p     'git-commit-nonempty-second-line-face nil))  )
