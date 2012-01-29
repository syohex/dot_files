;; yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")

;; selecting snippet with anything interface
(defun my-yas/prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  coice)))
         (selected (anything-other-buffer
                    `(((name . ,(format "%s" prompt))
                       (candidates . names)
                       (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*anything yas/prompt*")))
    (if selected
        (let ((n (position selected names :test 'equal)))
          (nth n choices))
      (signal 'quit "user quit!"))))
(custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
(global-set-key (kbd "C-x y") 'yas/insert-snippet)

(setq yas/trigger-key "TAB")
(when (require 'yasnippet-config nil t)
  (yas/setup "~/.emacs.d/plugins/yasnippet")
  (require 'anything-c-yasnippet)
  (setq anything-c-yas-space-match-any-greedy t)
  (global-set-key (kbd "C-c y") 'anything-c-yas-complete))

;; utility functions
(defun yas/perl-package-name ()
  (let ((file-path (file-name-sans-extension (buffer-file-name))))
    (if (string-match "lib/" file-path)
        (replace-regexp-in-string "/" "::"
                                  (car (last (split-string file-path "/lib/"))))
      (file-name-nondirectory file-path))))

;; enable yasnippet-mode in wl-draft-mode
(add-hook 'wl-draft-mode-hook
          '(lambda ()
             (yas/minor-mode)))
