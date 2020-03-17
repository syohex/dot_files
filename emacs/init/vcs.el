;;;; Common VCS setting
(custom-set-variables
 '(auto-revert-check-vc-info t)
 '(auto-revert-mode-text ""))
(global-auto-revert-mode 1)

;; disable vc-mode
(custom-set-variables
 '(vc-handled-backends '(Git))
 '(vc-follow-symlinks t))
(with-eval-after-load 'vc
  '(remove-hook 'find-file-hooks #'vc-find-file-hook))

;; vc
(global-set-key (kbd "C-x v d") #'vc-diff)

;; git-gutter
(global-git-gutter2-mode +1)
(global-set-key (kbd "C-x v u") 'git-gutter2-update)
(global-set-key (kbd "C-x v p") 'git-gutter2-stage-hunk)
(global-set-key (kbd "C-x v =") 'git-gutter2-popup-hunk)
(global-set-key (kbd "C-x v r") 'git-gutter2-revert-hunk)
(global-set-key (kbd "C-x v e") 'git-gutter2-end-of-hunk)

(custom-set-variables
 '(git-gutter2-verbosity 4)
 '(git-gutter2-modified-sign " ")
 '(git-gutter2-deleted-sign " "))

(add-hook 'focus-in-hook #'git-gutter2-update-all-windows)

(smartrep-define-key
    global-map  "C-x" '(("p" . 'git-gutter2-previous-hunk)
                        ("n" . 'git-gutter2-next-hunk)))

;; magit
(custom-set-variables
 '(git-commit-fill-column 80)
 '(git-commit-summary-max-length 72))

;; git-messenger
(custom-set-variables
 '(git-messenger:handled-backends '(git)))
(global-set-key (kbd "C-x v m") 'git-messenger:popup-message)
