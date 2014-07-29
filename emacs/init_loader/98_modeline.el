;; setting for modeline

;; Change lighter of major-mode and minor-mode
(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " Ys")
    (paredit-mode . " Pe")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (autopair-mode . " Ap")
    (undo-tree-mode . "")
    (elisp-slime-nav-mode . "")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    (git-gutter-mode . " GG")
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
