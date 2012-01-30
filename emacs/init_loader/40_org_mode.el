;; org-mode
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/repos/org-mode/lisp"))

(when (require 'org-install nil t)
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map (kbd "<f11>") 'org-remember)
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (org-remember-insinuate)
  (setq org-directory  (expand-file-name "~/.emacs.d/"))
  (setq org-default-notes-file (concat org-directory "notes.org"))
  (setq org-agenda-files '("~/.emacs.d/notes.org"))
  (setq org-remember-templates
        '(("Todo" ?t "** TODO %?\n  %T" nil nil)
          ("Bug" ?b "** TODO %?   :bug:\n   %i\n %T" nil nil)
          ("Idea" ?i "** %?\n  %T\n  %a" nil nil)))
  (setq org-startup-folded 'nofold)
  (setq org-use-fast-todo-selection t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
          (sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c)")))
  (setq org-todo-keyword-faces
        '(("TODO"      . org-warning)
          ("STARTED"   . (:foreground "deep sky blue" :weight bold))
          ("DONE"      . (:foreground "SpringGreen1" :weight bold))
          ("WAITING"   . (:foreground "orange" :weight bold))))

  ;; faces
  (set-face-foreground 'org-tag "green yellow")

  ;; hooks
  (add-hook 'org-mode-hook 'my/org-mode-hook))

(defun my/org-mode-hook ()
  (interactive)
  (local-set-key (kbd "C-M-<return>") 'org-insert-todo-heading)
  (local-unset-key (kbd "M-S-<return>")))

(eval-after-load "org"
  '(progn
     (smartrep-define-key
      org-mode-map "C-c" '(("C-n" . (lambda ()
                                      (outline-next-visible-heading 1)))
                           ("C-p" . (lambda ()
                                      (outline-previous-visible-heading 1)))))))
