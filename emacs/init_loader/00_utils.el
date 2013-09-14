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
