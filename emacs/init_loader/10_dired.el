;;;; dired
(eval-after-load "dired"
  '(progn
     ;; Not create new buffer, if you chenge directory in dired
     (put 'dired-find-alternate-file 'disabled nil)

     (when (executable-find "gls")
       (setq insert-directory-program "gls"))

     (load-library "ls-lisp")

     ;; binding
     (define-key dired-mode-map (kbd "D") 'sgit:diff)
     (define-key dired-mode-map (kbd "K") 'dired-k)
     (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
     (define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
     (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)))

(custom-set-variables
 '(ls-lisp-dirs-first t)
 '(dired-dwim-target t)
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always))

(autoload 'dired-jump "dired-x" nil t)
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; direx
(eval-after-load "direx"
  '(progn
     (define-key direx:direx-mode-map (kbd "K") 'direx-k)))

(defun my/direx-jump ()
  (interactive)
  (if (eq major-mode 'direx:direx-mode)
      (quit-window)
    (cond ((not (one-window-p))
           (or (ignore-errors
                 (direx-project:jump-to-project-root) t)
               (direx:jump-to-directory)))
          (t
           (or (ignore-errors
                 (direx-project:jump-to-project-root-other-window) t)
               (direx:jump-to-directory-other-window))))))
(global-set-key (kbd "C-\\") 'my/direx-jump)
