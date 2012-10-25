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

;; binding
(define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; helm in dired
(defvar my/helm-c-current-directory-source
  `((name . "Current Directory Files")
    (candidates . (lambda ()
                    (with-helm-current-buffer
                      (let ((dirs (directory-files (helm-c-current-directory)))
                            (filter (lambda (d) (string-match "^\.\.?$" d))))
                        (remove-if filter dirs)))))
    (action . (("Open File" . (lambda (c)
                                (find-file c)))))))

(defun my/helm-find-file-current-directory ()
  (interactive)
  (let ((curbuf (current-buffer))
        (orig-major major-mode))
    (if (helm-other-buffer 'my/helm-c-current-directory-source "*helm-dired*")
        (and (eq orig-major 'dired-mode) (kill-buffer curbuf)))))

(global-set-key (kbd "C-x C-p") 'my/helm-find-file-current-directory)
