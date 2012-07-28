;; Pomodoro technique in Emacs
(require 'pomodoro)
(defun toggle-pomodoro ()
  (interactive)
  (call-interactively (if pomodoro:timer
                          'pomodoro:stop
                        'pomodoro:start)))

(defun* my/pomodoro-notification (&key (title "Pomodoro")
                                       body
                                       (urgency 'critical))
  (notifications-notify :title title :body body :urgency urgency))

(add-hook 'pomodoro:finish-work-hook
          (lambda ()
            (my/pomodoro-notification :body "Work is Finish")))

(add-hook 'pomodoro:finish-rest-hook
          (lambda ()
            (my/pomodoro-notification :body "Break time is finished")))

(add-hook 'pomodoro:long-rest-hook
          (lambda ()
            (my/pomodoro-notification :body "Long Break time is finished")))

(defun my/pomodoro-insert-check (arg)
  (interactive "p")
  (dotimes (i arg)
    (insert "✓")))

(global-set-key (kbd "M-g M-i") 'my/pomodoro-insert-check)

(global-set-key (kbd "<f11>") (lambda ()
                                (interactive)
                                (find-file pomodoro:file)))
(global-set-key (kbd "M-g M-p") 'toggle-pomodoro)
