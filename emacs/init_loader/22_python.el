;; python-setting
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
     ;; (install-elisp "http://chrispoole.com/downloads/ac-python.el")
     (require 'ac-python)
     (when (boundp 'ac-modes)
       (setq ac-modes
             (append ac-modes '(python-3-mode python-2-mode))))

     ;; binding
     (define-key python-mode-map (kbd "<backtab>") 'python-back-indent)
     ;; Activate flymake unless buffer is a tmp buffer for the interpreter
     (unless (eq buffer-file-name nil)
       (flymake-mode t))))

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
