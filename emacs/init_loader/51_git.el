;;;; git-commit-mode
;; (install-elisp "https://github.com/rafl/git-commit-mode/raw/master/git-commit.el")
(require 'git-commit)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . git-commit-mode))
(set-face-foreground 'git-commit-summary-face nil)
(set-face-underline  'git-commit-summary-face t)
(set-face-foreground 'git-commit-nonempty-second-line-face nil)
(set-face-bold-p     'git-commit-nonempty-second-line-face nil)

;; gist
(require 'gist)

;; magit
(require 'magit)
(set-face-foreground 'magit-diff-add "green")
(set-face-foreground 'magit-diff-del "red")

;; for simple-git
(defvar sgit:buffer-name "*sgit*")

;; git status
(defun sgit:status ()
  (interactive)
  (let ((limit nil))
    (if (get-buffer sgit:buffer-name)
        (kill-buffer sgit:buffer-name))
    (with-current-buffer (get-buffer-create sgit:buffer-name)
      (setq buffer-read-only nil)
      (erase-buffer)
      (call-process "git" nil t nil "status")
      (goto-char (point-min))
      (save-excursion
        (if (re-search-forward "Changes not staged for commit:" nil t)
            (setq limit (point))))
      (when (re-search-forward "Changes to be committed:" limit t)
        (while (re-search-forward "modified:\s+" limit t)
          (let ((cur-point (match-beginning 0)))
            (end-of-line)
            (add-text-properties cur-point (point)
                                 `(face ((foreground-color . "green")
                                         (weight . bold)))))))
      (when (re-search-forward "Changes not staged for commit:" nil t)
        (while (re-search-forward "modified:\s+" nil t)
          (let ((cur-point (match-beginning 0)))
            (end-of-line)
            (add-text-properties cur-point (point)
                                 `(face ((foreground-color . "firebrick1")))))))
      (if limit
          (goto-char limit))
      (when (re-search-forward "Untracked files:" nil t)
        (forward-line 2)
        (while (re-search-forward "^#[\s\t]+\\([^\s\t]+\\)$" nil t)
          (end-of-line)
          (add-text-properties (match-beginning 1) (match-end 1)
                               `(face ((foreground-color . "cyan")
                                       (weight . bold))))))
      (goto-char (point-min))
      (setq buffer-read-only t))
    (pop-to-buffer sgit:buffer-name)
    (view-mode)))

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

(push '("*sgit*" :height 20) popwin:special-display-config)
