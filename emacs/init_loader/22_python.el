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
     (define-key python-mode-map (kbd "C-c C-i") 'my/python-insert-import-statement)
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

(defun my/python-insert-import-statement ()
  (interactive)
  (save-excursion
    (skip-chars-backward "^ \n")
    (let ((exp (thing-at-point 'symbol)))
      (when (string-match "^\\([^.]+\\)" exp)
        (let ((module (match-string 1 exp)))
          (save-excursion
            (if (re-search-backward (format "import %s" module) nil t)
                (error (format "already imported '%s'" module))))
          (if (re-search-backward "^import\\s-+" nil t)
              (forward-line 1)
            (progn
              (goto-char (point-min))
              (loop while (string-match "^#" (thing-at-point 'line))
                    do
                    (forward-line 1))))
          (let* ((imported (read-string "Import module: " module))
                 (import-statement (format "import %s\n" imported)))
            (insert import-statement)))))))

;; insert 'use Module' which is at cursor.
(defun cperl-insert-use-statement ()
  "use statement auto-insertion."
  (interactive)
  (let ((module-name (cperl-word-at-point))
        (insert-point (cperl-detect-insert-point)))
    (save-excursion
      (let ((use-statement (concat "\nuse " module-name ";")))
        (if (not (search-backward use-statement nil t))
            (progn
              (goto-char insert-point)
              (insert use-statement))
          (error "'%s' is already imported" module-name))))))

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
