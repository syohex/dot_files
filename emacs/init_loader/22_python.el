;; python-setting
(autoload 'python-mode "python" nil t)
(defadvice run-python (around run-python-no-sit activate)
  "Suppress absurd sit-for in run-python of python.el"
  (let ((process-launched (or (ad-get-arg 2) ; corresponds to `new`
                              (not (comint-check-proc python-buffer)))))
    (flet ((sit-for (seconds &optional nodisp)
                    (when process-launched
                      (accept-process-output (get-buffer-process python-buffer)))))
      ad-do-it)))

(eval-after-load "python"
  '(progn
     ;; auto-complete mode for python
     (add-to-list 'load-path "~/.emacs.d/emacs-jedi/")
     (require 'jedi)
     (local-unset-key (kbd "C-M-i"))
     (define-key python-mode-map (kbd "C-M-i") 'jedi:complete)
     (define-key python-mode-map (kbd "C-c C-d") 'jedi:show-doc)

     ;; pylookup
     (require 'pylookup)
     (setq pylookup-dir "~/.emacs.d/pylookup/")
     (add-to-list 'load-path pylookup-dir)

     ;; set executable file and db file
     (setq pylookup-program (concat pylookup-dir "/pylookup.py"))
     (setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

     ;; to speedup, just load it on demand
     (autoload 'pylookup-lookup "pylookup"
       "Lookup SEARCH-TERM in the Python HTML indexes." t)
     (autoload 'pylookup-update "pylookup"
       "Run pylookup-update and create the database at `pylookup-db-file'." t)

     (define-key python-mode-map (kbd "C-c C-l") 'pylookup-lookup)

     ;; flymake by flycheck
     (add-hook 'python-mode-hook 'flycheck-mode)

     ;; auto-pair
     (add-hook 'python-mode-hook 'my/wrap-region-as-autopair)

     ;; binding
     (define-key python-mode-map (kbd "C-M-d") 'my/python-next-block)
     (define-key python-mode-map (kbd "C-M-u") 'my/python-up-block)
     (define-key python-mode-map (kbd "C-c C-z") 'run-python)
     (define-key python-mode-map (kbd "<backtab>") 'python-back-indent)))

(defvar my/python-block-regexp
  "\\<\\(for\\|if\\|while\\|try\\|class\\|def\\)\\s-")

(defun my/python-next-block ()
  (interactive)
  (let ((orig (point))
        (new nil))
    (save-excursion
      (forward-char)
      (if (re-search-forward my/python-block-regexp nil t)
          (setq new (point))))
    (when new
      (goto-char new)
      (backward-word))))

(defun my/python-up-block ()
  (interactive)
  (let ((orig (point))
        (new nil))
    (save-excursion
      (backward-char)
      (if (re-search-backward my/python-block-regexp nil t)
          (setq new (point))))
    (when new
      (goto-char new))))

;; back indent
(defun python-back-indent ()
  (interactive)
  (let ((current-pos (point))
        (regexp-str (format " +\\{%d\\}" python-indent)))
   (save-excursion
     (beginning-of-line)
     (when (re-search-forward regexp-str current-pos t)
       (beginning-of-line)
       (delete-char python-indent)))))

(add-hook 'python-mode-hook 'jedi:setup)
