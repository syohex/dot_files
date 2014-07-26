;; setting for modeline

;; Change lighter of major-mode and minor-mode
(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " Ys")
    (paredit-mode . " Pe")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (autopair-mode . " ap")
    (undo-tree-mode . " Ut")
    (elisp-slime-nav-mode . " EN")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    (git-gutter-mode . " Git")
    ;; Major modes
    (lisp-interaction-mode . "Li")
    (git-commit-mode . "Commit")
    (python-mode . "Py")
    (ruby-mode   . "Rb")
    (emacs-lisp-mode . "El")
    (markdown-mode . "Md")))

(defun clean-mode-line ()
  (interactive)
  (cl-loop for (mode . mode-str) in mode-line-cleaner-alist
           do
           (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str))
             ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;; Show Git branch information to mode-line
(let ((cell (or (memq 'mode-line-position mode-line-format)
		(memq 'mode-line-buffer-identification mode-line-format)))
      (newcdr '(:eval (my/update-branch-mode-line))))
  (unless (member newcdr mode-line-format)
    (setcdr cell (cons newcdr (cdr cell)))))

(defun my/update-git-branch-mode-line ()
  (with-temp-buffer
    (when (zerop (call-process "git" nil t nil "symbolic-ref" "-q" "HEAD"))
      (goto-char (point-min))
      (when (re-search-forward "\\`refs/heads/\\(.+\\)$" nil t)
        (format "[%s]" (match-string-no-properties 1))))))

(defun my/update-hg-branch-mode-line ()
  (with-temp-buffer
    (when (zerop (call-process "hg" nil t nil "branch"))
      (goto-char (point-min))
      (format "[%s]" (buffer-substring-no-properties
                      (point) (line-end-position))))))

(defun my/update-branch-mode-line ()
  (let ((br-str (or (my/update-git-branch-mode-line)
                    (my/update-hg-branch-mode-line))))
    (propertize (or br-str "[Not Repo]")
                'face '((:foreground "GreenYellow" :weight bold)))))
