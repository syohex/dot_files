;;;; Common VCS setting
(custom-set-variables
 '(auto-revert-check-vc-info t))
(global-auto-revert-mode 1)

;; disable vc-mode
(custom-set-variables
 '(vc-handled-backends '())
 '(vc-follow-symlinks t))
(eval-after-load "vc"
  '(remove-hook 'find-file-hooks 'vc-find-file-hook))

;; sgit
(global-set-key (kbd "C-x v g") 'sgit:grep)
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v N") 'sgit:intent-to-add)

;; git-gutter
(global-git-gutter-mode +1)
(global-set-key (kbd "C-x v u") 'git-gutter)
(global-set-key (kbd "C-x v p") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(custom-set-variables
 '(git-gutter:modified-sign " ")
 '(git-gutter:deleted-sign " "))

(add-to-list 'git-gutter:update-hooks 'focus-in-hook)

(set-face-background 'git-gutter:deleted  "red")
(set-face-background 'git-gutter:modified "magenta")

(smartrep-define-key
    global-map  "C-x" '(("p" . 'git-gutter:previous-diff)
                        ("n" . 'git-gutter:next-diff)))

;; magit
(custom-set-variables
 '(magit-auto-revert-mode-lighter ""))

(global-set-key (kbd "M-g M-g") 'magit-status)
(eval-after-load "magit"
  '(progn

     (defadvice magit-status (around magit-fullscreen activate)
       (window-configuration-to-register :magit-fullscreen)
       ad-do-it
       (delete-other-windows))

     (define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session)

     ;; faces
     (set-face-attribute 'magit-branch nil
                         :foreground "yellow" :weight 'bold :underline t)
     (set-face-attribute 'magit-item-highlight nil
                         :background "gray3" :weight 'normal)))

(defun my/magit-quit-session ()
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen)
  (dolist (win (window-list))
    (let ((buf (window-buffer win)))
      (with-current-buffer buf
        (when git-gutter-mode
          (git-gutter))))))

(defun my/git-commit-mode-hook ()
  (when (looking-at "\n")
    (open-line 1)))

(eval-after-load "git-commit-mode"
  '(progn
     (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
     (add-hook 'git-commit-mode-hook 'my/git-commit-mode-hook)))

(defadvice git-commit-commit (after move-to-magit-buffer activate)
  (delete-window))

;; helm-open-github
(global-set-key (kbd "C-c o f") 'helm-open-github-from-file)
(global-set-key (kbd "C-c o c") 'helm-open-github-from-commit)
(global-set-key (kbd "C-c o i") 'helm-open-github-from-issues)
(global-set-key (kbd "C-c o p") 'helm-open-github-from-pull-requests)
