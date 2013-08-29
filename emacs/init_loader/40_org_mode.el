;; org-mode
(define-key global-map (kbd "C-c l") 'org-store-link)

(eval-after-load "org"
  '(progn
     (setq org-startup-truncated nil
           org-return-follows-link t
           org-directory (expand-file-name "~/Dropbox/")
           org-agenda-files (list org-directory)
           org-use-fast-todo-selection t
           org-src-fontify-natively t)

     (setq org-todo-keywords
           '((sequence "TODO(t)" "DOING(s)" "BLOCKED(w)" "|" "DONE(x)" "ARCHIVED(c)")
             (sequence "FIX" "BUG" "ISSUES" "PR" "|" "DONE(x)" "CANCEL(c)")))

     (setq org-todo-keyword-faces
           '(("TODO" . org-warning)
             ("DOING" . "yellow") ("BLOCKED" . "firebrick1")
             ("REVIEW" . "orange") ("DONE" . "green") ("ARCHIVED" . "blue")
             ("FIX" . "orange") ("BUG" . "orange") ("ISSUES" . "orange")
             ("PR" . "orange")))

     ;; function of org-open-at-point
     ;;(setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

     (define-key org-mode-map (kbd "C-t") 'org-mark-ring-goto)
     (define-key org-mode-map (kbd "C-c t") 'org-toggle-link-display)
     (define-key org-mode-map (kbd "C-M-<return>") 'org-insert-todo-heading)
     (define-key org-mode-map (kbd "C-M-<tab>") 'show-all)
     (local-unset-key (kbd "M-S-<return>"))

     (smartrep-define-key
         org-mode-map "C-c" '(("f" . 'org-shiftright)
                              ("b" . 'org-shiftleft)))
     (smartrep-define-key
         org-mode-map "C-c" '(("C-n" . (outline-next-visible-heading 1))
                              ("C-p" . (outline-previous-visible-heading 1))))))

(eval-after-load "org-faces"
  '(progn
     (set-face-foreground 'org-block "green")
     (set-face-foreground 'org-tag "green yellow")
     (set-face-foreground 'org-checkbox "LawnGreen")

     (set-face-attribute 'org-warning nil :foreground "hotpink")
     (set-face-attribute 'org-level-1 nil :foreground "hotpink" :weight 'bold)
     (set-face-attribute 'org-level-2 nil :foreground "yellow" :weight 'semi-bold)
     (set-face-attribute 'org-level-4 nil :foreground "grey80")))
