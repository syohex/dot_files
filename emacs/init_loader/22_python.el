;; python-setting
(defadvice run-python (around run-python-no-sit activate)
  "Suppress absurd sit-for in run-python of python.el"
  (let ((process-launched (or (ad-get-arg 2) ; corresponds to `new`
                              (not (comint-check-proc python-buffer)))))
    (flet ((sit-for (seconds &optional nodisp)
                    (when process-launched
                      (accept-process-output (get-buffer-process python-buffer)))))
      ad-do-it)))

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

;; auto-complete mode for python
(require 'ac-python)

(when (boundp 'ac-modes)
  (setq ac-modes
        (append ac-modes '(python-3-mode python-2-mode))))

;; blockdiag
(defun blockdiag-buffer ()
  (interactive)
  (let ((blockdiag-output "/tmp/blockdiag-buffer.png")
        (current-file (buffer-file-name (current-buffer))))
    (call-process "blockdiag" nil nil t "-o" blockdiag-output current-file)
    (switch-to-buffer-other-window
     (get-buffer-create "*blockdiag*"))
    (erase-buffer)
    (insert-file blockdiag-output)
    (image-mode)))

(push '("*blockdiag*") popwin:special-display-config)

;; back indent
(require 'python)
(defun python-back-indent ()
  (interactive)
  (let ((current-pos (point))
        (regexp-str (format " +\\{%d\\}" python-indent)))
   (save-excursion
     (beginning-of-line)
     (when (re-search-forward regexp-str current-pos t)
       (beginning-of-line)
       (delete-char python-indent)))))

(define-key python-mode-map (kbd "<backtab>") 'python-back-indent)
