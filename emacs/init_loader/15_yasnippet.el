;;;; yasnippet

;; enable yasnippet mode
(autoload 'yas-minor-mode-on "yasnippet" nil t)
(dolist (hook '(c-mode-hook
                java-mode-hook
                cperl-mode-hook
                emacs-lisp-mode-hook
                html-mode
                js-mode-hook
                python-mode-hook
                ruby-mode-hook
                go-mode-hook
                sh-mode-hook
                wl-draft-mode-hook))
  (add-hook hook 'yas-minor-mode-on))

;; helm interface
(defun my/yas-prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  coice)))
         (selected (helm-other-buffer
                    `(((name . ,(format "%s" prompt))
                       (candidates . names)
                       (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*helm yas/prompt*")))
    (if selected
        (nth (position selected names :test 'equal) choices)
      (signal 'quit "user quit!"))))

(global-set-key (kbd "M-=") 'yas-insert-snippet)

(eval-after-load "yasnippet"
  '(progn
     (setq-default yas-snippet-dirs (concat user-emacs-directory "my_snippets")
                   yas-prompt-functions '(my/yas-prompt))
     (yas-reload-all)))

;; utility functions
(defun my-yas/perl-package-name ()
  (let ((file-path (file-name-sans-extension (buffer-file-name))))
    (if (string-match "lib/\\(.+\\)\\'" file-path)
        (replace-regexp-in-string "/" "::" (match-string 1 file-path))
      (file-name-nondirectory file-path))))

(defun my-yas/parent-directory ()
  (let ((curdir (directory-file-name (file-name-directory (buffer-file-name)))))
    (file-name-nondirectory curdir)))
