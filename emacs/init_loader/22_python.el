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

(eval-after-load "python-mode"
  '(progn
     ;; auto-complete mode for python
     ;; (auto-install-from-url "http://chrispoole.com/downloads/ac-python.el")
     (require 'ac-python)
     (when (boundp 'ac-modes)
       (setq ac-modes
             (append ac-modes '(python-3-mode python-2-mode))))

     ;; pylookup
     (require 'pylookup)
     (setq pylookup-dir "~/.emacs.d/pylookup")
     (add-to-list 'load-path pylookup-dir)

     ;; set executable file and db file
     (setq pylookup-program (concat pylookup-dir "/pylookup.py"))
     (setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

     ;; to speedup, just load it on demand
     (autoload 'pylookup-lookup "pylookup"
       "Lookup SEARCH-TERM in the Python HTML indexes." t)
     (autoload 'pylookup-update "pylookup"
       "Run pylookup-update and create the database at `pylookup-db-file'." t)

     (define-key python-mode-map (kbd "C-c C-d") 'pylookup-lookup)

     ;; binding
     (define-key python-mode-map (kbd "C-j") 'python-newline-and-indent)
     (define-key python-mode-map (kbd "<backtab>") 'python-back-indent)
     ;; Activate flymake unless buffer is a tmp buffer for the interpreter
     (unless (eq buffer-file-name nil)
       (flymake-mode t))))

(defun python-newline-and-indent ()
  (interactive)
  (let (current-line-is-open-block)
    (when (and (eolp) (not (char-equal ?: (preceding-char))))
      (save-excursion
        (back-to-indentation)
        (if (python-open-block-statement-p t)
            (setq current-line-is-open-block t))))
    (when current-line-is-open-block
      (skip-chars-backward " \t")
      (insert ":")))
  (newline-and-indent))

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

;; flymake setting(need to install 'pyflakes': pip install pyflakes)
(defun flymake-python-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "pyflakes" (list local-file))))

(defconst flymake-allowed-python-file-name-masks '(("\\.py$" flymake-python-init)))

(defun flymake-python-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks
                flymake-allowed-python-file-name-masks))
  (setq flymake-python-err-line-patterns
        (cons '("\\(.*\\):\\([0-9]+\\):\\(.*\\)" 1 2 nil 3)
              flymake-err-line-patterns))
  (flymake-mode t))

(add-hook 'python-mode-hook '(lambda () (flymake-python-load)))
