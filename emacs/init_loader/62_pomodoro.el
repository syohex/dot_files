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

(defun my/pomodoro-find-file ()
  (interactive)
  (let ((file (concat user-emacs-directory "pomodoro.org")))
    (if current-prefix-arg
        (elscreen-find-file file)
      (find-file file))))

(global-set-key (kbd "<f11>") 'my/pomodoro-find-file)
