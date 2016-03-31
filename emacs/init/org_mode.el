;; org-mode
(global-set-key (kbd "C-x L") 'org-store-link)
(global-set-key (kbd "C-x r a") 'org-agenda)

(custom-set-variables
 '(org-startup-truncated nil)
 '(org-directory (expand-file-name "~/Dropbox/"))
 '(org-agenda-files (list "~/TODO/"))
 '(org-return-follows-link t)
 '(org-use-fast-todo-selection t)
 '(org-src-fontify-natively t)
 '(org-default-notes-file (concat org-directory "organizer.org"))
 '(org-todo-keywords
   '((sequence "TODO(t)" "DOING(d)" "|" "DONE(x)" "BLOCKED(b)" "CANCEL(c)")))
 '(org-todo-keyword-faces
   '(("TODO" . org-warning)
     ("DOING" . (:foreground "orange" :underline t :weight bold))
     ("BLOCKED" . "firebrick1") ("DONE" . "green") ("CANCEL" . "SteelBlue"))))

(with-eval-after-load 'org
  (add-hook 'org-mode-hook 'my/org-mode-hook)

  ;; function of org-open-at-point
  ;;(setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

  (define-key org-mode-map (kbd "M-,") 'org-mark-ring-goto)
  (define-key org-mode-map (kbd "C-c t") 'org-toggle-link-display)
  (define-key org-mode-map (kbd "C-M-<return>") 'org-insert-todo-heading)
  (define-key org-mode-map (kbd "C-c <tab>") 'outline-show-all)

  (smartrep-define-key
      org-mode-map "C-c" '(("l" . 'org-shiftright)
                           ("h" . 'org-shiftleft)))

  (smartrep-define-key
      org-mode-map "C-c" '(("j" . 'org-metadown)
                           ("k" . 'org-metaup))))

(defun my/org-mode-hook ()
  (local-unset-key (kbd "M-S-<return>")))
