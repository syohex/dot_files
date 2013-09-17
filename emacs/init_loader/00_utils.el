;; use cl functions and macros in my config files.
(require 'cl)

;; decide system is MacOSX
(defun macosx-p ()
  (eq system-type 'darwin))

(defun linux-p ()
  (eq system-type 'gnu/linux))

;; anaphoric macro
(defmacro aif (test then &rest else)
  "Anaphoric if."
  (declare (indent 2))
  `(let ((it ,test))
     (if it ,then ,@else)))

;; my memo utility
(defun my/open-daily-memo ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/daily.org")))

(defun my/open-task-memo ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/task.org")))
