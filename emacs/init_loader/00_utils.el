;; use cl functions and macros in my config files.
(require 'cl-lib)

;; my memo utility
(defun my/open-daily-memo ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/today.org")))

(defun my/open-task-memo ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/task.org")))
