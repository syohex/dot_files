;;;; Common VCS setting
(global-auto-revert-mode 1)
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; disable vc-mode
(setq vc-handled-backends '())

;;; Setting for Git
(defun my/git-intent-to-add ()
  (interactive)
  (save-buffer)
  (let* ((file (file-name-nondirectory (buffer-file-name)))
         (cmd (format "git add -N %s" file)))
    (unless (zerop (call-process-shell-command cmd))
      (error "Failed: %s" cmd))
    (message "Success: %s" cmd))
  (git-gutter))
(global-set-key (kbd "C-x v N") 'my/git-intent-to-add)

;; sgit
(require 'sgit)
(global-set-key (kbd "C-x v l") 'sgit:log)
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v s") 'sgit:status)

;; git-gutter
(global-git-gutter-mode t)
(global-set-key (kbd "C-x =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(smartrep-define-key
    global-map  "C-x" '(("p" . 'git-gutter:previous-diff)
                        ("n" . 'git-gutter:next-diff)))

(eval-after-load "git-gutter"
  '(progn
     (if (macosx-p)
         (setq git-gutter:added-sign "+ "
               git-gutter:deleted-sign " "
               git-gutter:modified-sign " ")
       (setq git-gutter:modified-sign " "
             git-gutter:deleted-sign " "))
     (set-face-background 'git-gutter:deleted  "red")
     (set-face-background 'git-gutter:modified "magenta")))

;; magit
(global-set-key (kbd "M-g M-g") 'magit-status)
(eval-after-load "magit"
  '(progn
     (define-key magit-mode-map (kbd "C-c C-b") 'magit-browse)
     (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)

     ;; faces
     (set-face-attribute 'magit-branch nil
                         :foreground "yellow" :weight 'bold :underline t)
     (set-face-attribute 'magit-item-highlight nil
                         :background "gray3" :weight 'normal)))

(defun my/magit-log-edit-mode-hook ()
  (flyspell-mode t)
  (push 'ac-source-look ac-sources))
(add-hook 'magit-log-edit-mode-hook 'my/magit-log-edit-mode-hook)
