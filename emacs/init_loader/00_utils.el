;; use cl functions and macros in my config files.
(require 'cl)

;; decide system is MacOSX
(defun macosx-p ()
  (eq system-type 'darwin))

(defun linux-p ()
  (eq system-type 'gnu/linux))

;; I use notification anywhere
(when (linux-p)
  (require 'notifications))

;; anaphoric macro
(defmacro aif (test then &rest else)
  "Anaphoric if."
  (declare (indent 2))
  `(let ((it ,test))
     (if it ,then ,@else)))

;; create temp buffer
(defun create-temporary-buffer (bufname)
  (interactive
   (list (read-string "Buffer Name: ")))
  (switch-to-buffer (generate-new-buffer (format "*%s*" bufname)))
  (erase-buffer)
  (setq buffer-offer-save nil))
