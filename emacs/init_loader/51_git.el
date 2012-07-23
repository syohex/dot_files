;;;; git-commit-mode
;; (auto-install-from-url "https://github.com/rafl/git-commit-mode/raw/master/git-commit.el")
(autoload 'git-commit-mode "git-commit" nil t)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . git-commit-mode))
(eval-after-load "git-commit"
  '(progn
     (set-face-foreground 'git-commit-summary-face nil)
     (set-face-underline  'git-commit-summary-face t)
     (set-face-foreground 'git-commit-nonempty-second-line-face nil)
     (set-face-bold-p     'git-commit-nonempty-second-line-face nil)))

;; for simple-git
(defvar sgit:buffer-name "*sgit*")

;; git diff
(defun sgit:diff ()
  (interactive)
  (let ((filename (if current-prefix-arg
                      "."
                    (buffer-file-name (current-buffer)))))
    (if (get-buffer sgit:buffer-name)
        (kill-buffer sgit:buffer-name))
    (with-current-buffer (get-buffer-create sgit:buffer-name)
      (setq buffer-read-only nil)
      (erase-buffer)
      (call-process "git" nil t nil "diff" filename)
      (goto-char (point-min))
      (setq buffer-read-only t))
  (pop-to-buffer sgit:buffer-name)
  (diff-mode)
  (view-mode)))

;; git log
(defun sgit:log ()
  (interactive)
  (let ((filename (if current-prefix-arg
                      "."
                    (buffer-file-name (current-buffer)))))
    (if (get-buffer sgit:buffer-name)
        (kill-buffer sgit:buffer-name))
    (with-current-buffer (get-buffer-create sgit:buffer-name)
      (setq buffer-read-only nil)
      (erase-buffer)
      (call-process "git" nil t nil "log" "-p" filename)
      (goto-char (point-min))
      (setq buffer-read-only t))
  (pop-to-buffer sgit:buffer-name)
  (diff-mode)
  (view-mode)))

(set-face-attribute 'diff-context nil
                    :background nil :foreground "gray"
                    :weight 'normal)

;; binding
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v l") 'sgit:log)
