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

;; git-gutter
(global-set-key (kbd "C-x v g") 'git-gutter)
(eval-after-load "git-gutter"
  '(progn
     (setq git-gutter:modified-sign " ")
     (set-face-background 'git-gutter:modified "purple")))

;; magit
(global-set-key (kbd "M-g M-g") 'magit-status)
(eval-after-load "magit"
  '(progn
     (set-face-attribute 'magit-item-highlight nil
                         :background "gray3")))

(defun my/magit-log-mode-hook ()
  (when (eq major-mode 'magit-log-edit-mode)
    (flyspell-mode t)))

(add-hook 'after-change-major-mode-hook 'my/magit-log-mode-hook)
