;; use cl functions and macros in my config files.
(require 'cl)

;; my utilities
(require 'pomodoro)
(defun toggle-pomodoro ()
  (interactive)
  (call-interactively (if pomodoro:timer
                          'pomodoro:stop
                        'pomodoro:start)))

(global-set-key (kbd "M-g M-i") (lambda (arg)
                                  (interactive "p")
                                  (loop for i from 1 to arg
                                        do (insert "✓"))))
(global-set-key (kbd "<f11>") (lambda ()
                                (interactive)
                                (find-file pomodoro:file)))
(global-set-key (kbd "M-g M-p") 'toggle-pomodoro)
