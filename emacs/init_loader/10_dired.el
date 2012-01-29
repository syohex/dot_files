;;;; dired
(require 'dired)
;; Not create new buffer, if you chenge directory in dired
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;; display directories by first
(load-library "ls-lisp")
(setq ls-lisp-dirs-first t)
;; recursive copy, remove
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; dired-x
(load "dired-x")

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; anything in dired
(defun my/anything-dired ()
  (interactive)
  (let ((curbuf (current-buffer)))
    (if (anything-other-buffer
         '(anything-c-source-files-in-current-dir+)
         " *anything-dired*")
        (kill-buffer curbuf))))

(define-key dired-mode-map (kbd "p") 'my/anything-dired)

;; direx
(require 'direx)
