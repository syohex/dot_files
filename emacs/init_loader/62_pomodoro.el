;; Pomodoro technique in Emacs
(autoload 'pomodoro:start "pomodoro" nil t)
(eval-after-load "pomodoro"
  '(progn
     (add-hook 'pomodoro:finish-work-hook
               (my/pomodoro-notification :body "Work is Finish"))

     (add-hook 'pomodoro:finish-rest-hook
               (my/pomodoro-notification :body "Break time is finished"))

     (add-hook 'pomodoro:long-rest-hook
               (my/pomodoro-notification :body "Long Break time now"))

     (global-set-key (kbd "M-g M-i") 'my/pomodoro-insert-check)))

(defun* my/pomodoro-notification (&key (title "Pomodoro")
                                       body
                                       (urgency 'critical))
  (lambda ()
    (notifications-notify :title title :body body :urgency urgency)))

(defun my/pomodoro-insert-check (arg)
  (interactive "p")
  (dotimes (i arg)
    (insert "✓")))

(global-set-key (kbd "<f11>") (lambda ()
                                (interactive)
                                (find-file "~/.emacs.d/pomodoro.org")))
