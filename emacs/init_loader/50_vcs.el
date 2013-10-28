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
(dolist (sgit-func '(sgit:log sgit:diff sgit:status sgit:grep))
  (autoload sgit-func "sgit" nil t))
(global-set-key (kbd "C-x v g") 'sgit:grep)
(global-set-key (kbd "C-x v l") 'sgit:log)
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v s") 'sgit:status)

;; git-gutter
(global-git-gutter-mode +1)
(global-set-key (kbd "C-x v u") 'git-gutter)
(global-set-key (kbd "C-x v p") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
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
(global-set-key (kbd "M-g M-b") 'magit-branch-manager)
(eval-after-load "magit"
  '(progn

     (defadvice magit-status (around magit-fullscreen activate)
       (window-configuration-to-register :magit-fullscreen)
       ad-do-it
       (delete-other-windows))

     (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)
     (define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session)

     ;; faces
     (set-face-attribute 'magit-branch nil
                         :foreground "yellow" :weight 'bold :underline t)
     (set-face-attribute 'magit-item-highlight nil
                         :background "gray3" :weight 'normal)))

(defun my/magit-quit-session ()
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(defun my/git-commit-mode-hook ()
  (when (looking-at "\n")
    (open-line 1))
  (flyspell-mode t)
  (push 'ac-source-look ac-sources))
(add-hook 'git-commit-mode-hook 'my/git-commit-mode-hook)

(defadvice git-commit-commit (after move-to-magit-buffer activate)
  (delete-window))

(defun my/magit-commit ()
  (interactive)
  (let ((magit-custom-options '("-v")))
    (magit-commit)))
(global-set-key (kbd "C-x v c") 'my/magit-commit)

;; helm-open-github
(global-set-key (kbd "C-x v f") 'helm-open-github-from-file)
(global-set-key (kbd "C-x v c") 'helm-open-github-from-commit)
(global-set-key (kbd "C-x v i") 'helm-open-github-from-issues)
