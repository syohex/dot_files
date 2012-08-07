;; Pomodoro technique in Emacs
(require 'pomodoro)

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
            (my/pomodoro-notification :body "Long Break time now")))

(defun my/pomodoro-insert-check (arg)
  (interactive "p")
  (dotimes (i arg)
    (insert "✓")))

(global-set-key (kbd "M-g M-i") 'my/pomodoro-insert-check)

(global-set-key (kbd "<f11>") (lambda ()
                                (interactive)
                                (find-file pomodoro:file)))

(defun show-todo (target)
  (interactive
   (list (completing-read "Target: " '("priority" "work" "private") nil t)))
  (cond ((string= target "work")
         (find-file "~/Dropbox/emacs/todo/work.org"))
        ((string= target "private")
         (find-file "~/Dropbox/emacs/todo/private.org"))
        ((string= target "priority")
         (find-file "~/Dropbox/emacs/todo/priority.org"))
        (t (error "Never reach here!!"))))

(global-set-key (kbd "<f10>") 'show-todo)
