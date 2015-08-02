;;;; Common VCS setting
(custom-set-variables
 '(auto-revert-check-vc-info t))
(global-auto-revert-mode 1)

;; disable vc-mode
(custom-set-variables
 '(vc-handled-backends '(Git))
 '(vc-follow-symlinks t))
(with-eval-after-load 'vc
  '(remove-hook 'find-file-hooks 'vc-find-file-hook))

;; vc
(global-set-key (kbd "C-x v d") 'vc-diff)

;; git-gutter
(global-git-gutter-mode +1)
(global-set-key (kbd "C-x v u") 'git-gutter)
(global-set-key (kbd "C-x v p") 'git-gutter:stage-hunk)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(custom-set-variables
 '(git-gutter:verbosity 4)
 '(git-gutter:modified-sign " ")
 '(git-gutter:deleted-sign " "))

(add-hook 'focus-in-hook 'git-gutter:update-all-windows)

(smartrep-define-key
    global-map  "C-x" '(("p" . 'git-gutter:previous-diff)
                        ("n" . 'git-gutter:next-diff)))

;; magit
(custom-set-variables
 '(git-commit-summary-max-length 72)
 '(magit-auto-revert-mode-lighter ""))

(defun my/magit-status-around (orig-fn &rest args)
  (window-configuration-to-register :magit-fullscreen)
  (apply orig-fn args)
  (delete-other-windows))

(global-set-key (kbd "M-g M-g") 'magit-status)
(global-set-key (kbd "C-x v l") 'magit-log)

(with-eval-after-load 'magit
  (global-git-commit-mode +1)
  (advice-add 'magit-status :around 'my/magit-status-around)

  (define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session))

(defun my/magit-quit-session ()
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen)
  (git-gutter:update-all-windows))

(custom-set-variables
 '(git-commit-fill-column 80))

(defun my/git-commit-commit-after (_unused)
  (delete-window))

(defun my/git-commit-mode-hook ()
  ;;(setq-local company-backends '(company-ispell company-capf company-files company-dabbrev))
  (flyspell-mode +1))

(with-eval-after-load 'git-commit
  (define-key git-commit-mode-map (kbd "C-M-i") 'auto-complete)

  (add-hook 'git-commit-mode-hook 'my/git-commit-mode-hook)
  (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)

  (advice-add 'git-commit-commit :after 'my/git-commit-commit-after))

;; helm-open-github
(global-set-key (kbd "C-c o f") 'helm-open-github-from-file)
(global-set-key (kbd "C-c o c") 'helm-open-github-from-commit)
(global-set-key (kbd "C-c o i") 'helm-open-github-from-issues)
(global-set-key (kbd "C-c o p") 'helm-open-github-from-pull-requests)
