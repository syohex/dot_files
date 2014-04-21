;; org-mode
(define-key global-map (kbd "C-x L") 'org-store-link)

(custom-set-variables
 '(org-startup-truncated nil)
 '(org-directory (expand-file-name "~/Dropbox/"))
 '(org-agenda-files (list org-directory))
 '(org-return-follows-link t)
 '(org-use-fast-todo-selection t)
 '(org-src-fontify-natively t)
 '(org-todo-keywords
   '((sequence "TODO(t)" "DOING(d)" "|" "DONE(x)" "BLOCKED(b)" "CANCEL(c)")))
 '(org-todo-keyword-faces
   '(("TODO" . org-warning)
     ("DOING" . (:foreground "orange" :underline t :weight bold))
     ("BLOCKED" . "firebrick1") ("DONE" . "green") ("CANCEL" . "SteelBlue"))))

(eval-after-load "org"
  '(progn
     ;; function of org-open-at-point
     ;;(setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

     (define-key org-mode-map (kbd "M-,") 'org-mark-ring-goto)
     (define-key org-mode-map (kbd "C-c t") 'org-toggle-link-display)
     (define-key org-mode-map (kbd "C-M-<return>") 'org-insert-todo-heading)
     (define-key org-mode-map (kbd "C-M-<tab>") 'show-all)
     (local-unset-key (kbd "M-S-<return>"))

     (smartrep-define-key
         org-mode-map "C-c" '(("l" . 'org-shiftright)
                              ("h" . 'org-shiftleft)))

     (smartrep-define-key
         org-mode-map "C-c" '(("j" . 'org-metadown)
                              ("k" . 'org-metaup)))

     (smartrep-define-key
         org-mode-map "C-c" '(("C-f" . (outline-forward-same-level 1))
                              ("C-b" . (outline-backward-same-level 1))))

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
