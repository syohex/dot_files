(eval-when-compile
  (require 'cl))

;; predicate, Is your system Mac OSX
(defun system-macosx-p ()
  (string= system-type "darwin"))

;; predicate, Is your system Linux
(defun system-linux-p ()
  (string= system-type "gnu/linux"))
