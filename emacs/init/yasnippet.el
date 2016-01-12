;;;; yasnippet

;; enable yasnippet mode
(dolist (hook '(c-mode-hook
                c++-mode-hook
                java-mode-hook
                cperl-mode-hook
                emacs-lisp-mode-hook
                elixir-mode-hook
                html-mode-hook
                js-mode-hook
                python-mode-hook
                ruby-mode-hook
                go-mode-hook
                sh-mode-hook
                markdown-mode-hook
                makefile-mode-hook
                text-mode))
  (add-hook hook 'yas-minor-mode))

(with-eval-after-load 'yasnippet
  (setq-default yas-verbosity 1)
  (setq-default yas-snippet-dirs (concat user-emacs-directory "my_snippets"))
  (yas-reload-all))

;; utility functions
(defun my-yas/perl-package-name ()
  (let ((file-path (file-name-sans-extension (buffer-file-name))))
    (if (string-match "lib/\\(.+\\)\\'" file-path)
        (replace-regexp-in-string "/" "::" (match-string 1 file-path))
      (file-name-nondirectory file-path))))

(defun my-yas/parent-directory ()
  (let ((curdir (directory-file-name (file-name-directory (buffer-file-name)))))
    (file-name-nondirectory curdir)))
