;; yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")

(setq yas/trigger-key "SPC")
(setq yas/trigger-key "TAB")

(when (require 'yasnippet-config nil t)
  (yas/setup "~/.emacs.d/plugins/yasnippet")
  (require 'anything-c-yasnippet)
  (setq anything-c-yas-space-match-any-greedy t)
  (global-set-key (kbd "M-=") 'anything-c-yas-complete))

;; utility functions
(defun yas/perl-package-name ()
  (let ((file-path (file-name-sans-extension (buffer-file-name))))
    (if (string-match "lib/" file-path)
        (replace-regexp-in-string "/" "::"
                                  (car (last (split-string file-path "/lib/"))))
      (file-name-nondirectory file-path))))

;; Load own snippet directories
(defun yas/load-all-directories ()
  (interactive)
  (yas/reload-all)
  (mapc 'yas/load-directory-1 '("~/.emacs.d/my_snippets")))
(yas/load-all-directories)
