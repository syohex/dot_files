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
     (define-key magit-mode-map (kbd "C-c C-b") 'magit-browse)

     ;; faces
     (set-face-attribute 'magit-branch nil
                         :foreground "yellow" :weight 'bold :underline t)
     (set-face-attribute 'magit-item-highlight nil
                         :background "gray3")))

(add-hook 'magit-mode-hook (lambda () (yas-minor-mode -1)))

(defun my/magit-log-edit-mode-hook ()
  (flyspell-mode t)
  (push 'ac-source-look ac-sources))
(add-hook 'magit-log-edit-mode-hook 'my/magit-log-edit-mode-hook)

(defun magit-browse ()
  (interactive)
  (let ((url (with-temp-buffer
               (unless (zerop (call-process-shell-command "git remote -v" nil t))
                 (error "Failed: 'git remote -v'"))
               (goto-char (point-min))
               (when (re-search-forward "github\\.com[:/]\\(.+?\\)\\.git" nil t)
                 (format "https://github.com/%s" (match-string 1))))))
    (unless url
      (error "Can't find repository URL"))
    (browse-url url)))
