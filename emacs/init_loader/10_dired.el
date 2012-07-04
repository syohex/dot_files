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

;; helm in dired
(defun my/helm-dired ()
  (interactive)
  (let ((curbuf (current-buffer)))
    (if (helm-other-buffer
         'helm-c-source-files-in-current-dir
         "*helm-dired*")
        (kill-buffer curbuf))))

(define-key dired-mode-map (kbd "p") 'my/helm-dired)
(global-set-key (kbd "C-x C-p") 'my/helm-dired)

;;;; direx
;; (auto-install-from-url "https://raw.github.com/m2ym/direx-el/master/direx.el")
(require 'direx)
