;;;; Common VCS setting
(global-auto-revert-mode 1)
(setq auto-revert-interval 10)
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; disable vc-mode
(setq vc-handled-backends '())

;;; git
;; sgit
(require 'sgit)
(global-set-key (kbd "C-x v g") 'sgit:grep)
(global-set-key (kbd "C-x v l") 'sgit:log)
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v s") 'sgit:status)

;; List files in git repos
(defun helm-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files" . "--modified")
          ("Untracked files" . "--others --exclude-standard")
          ("All controlled files in this project" . nil))
        for title  = (format "%s (%s)" (car elt) pwd)
        for option = (cdr elt)
        for cmd    = (format "git ls-files %s" (or option ""))
        collect
        `((name . ,title)
          (init . (lambda ()
                    (unless (and (not ,option) (helm-candidate-buffer))
                      (with-current-buffer (helm-candidate-buffer 'global)
                        (call-process-shell-command ,cmd nil t nil)))))
          (candidates-in-buffer)
          (type . git-file))))

(defun helm-git-project-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))

(defun helm-git-project ()
  (interactive)
  (let ((topdir (helm-git-project-topdir)))
    (unless (file-directory-p topdir)
      (error "I'm not in Git Repository!!"))
    (let* ((default-directory topdir)
           (sources (helm-c-sources-git-project-for default-directory)))
      (helm-other-buffer sources "*helm git project*"))))
(define-key global-map (kbd "C-;") 'helm-git-project)

;; git-commit-mode
(autoload 'git-commit-mode "git-commit" nil t)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . git-commit-mode))

(eval-after-load "git-commit"
  '(progn
     (add-hook 'git-commit-mode-hook 'auto-complete-mode)
     (add-hook 'git-commit-mode-hook 'flyspell-mode)
     (set-face-foreground 'git-commit-summary-face nil)
     (set-face-underline  'git-commit-summary-face t)
     (set-face-foreground 'git-commit-nonempty-second-line-face nil)
     (set-face-bold-p     'git-commit-nonempty-second-line-face nil)))
