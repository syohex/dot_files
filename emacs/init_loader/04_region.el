;;;; region setting

;; multimark
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)

(eval-after-load "multiple-cursors-core"
  '(progn
     (dolist (command '(delete-cursor-word-or-region
                        paredit-forward-delete
                        paredit-forward-kill-word
                        my/backward-kill-word
                        my/delete-word
                        c-electric-delete-forward
                        cperl-electric-semi))
       (add-to-list 'mc/cmds-to-run-for-all command))))

;; wrap-region
(wrap-region-global-mode +1)

;; add wrappers
(wrap-region-add-wrapper "`" "`")
(wrap-region-add-wrapper "{" "}")

;; disable paredit enable mode
(dolist (mode (append '(emacs-lisp-mode scheme-mode lisp-mode clojure-mode)
                      my/autopair-enabled-modes))
  (add-to-list 'wrap-region-except-modes mode))
