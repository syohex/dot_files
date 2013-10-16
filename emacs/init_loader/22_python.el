;; python-setting
(defadvice run-python (around run-python-no-sit activate)
  "Suppress absurd sit-for in run-python of python.el"
  (let ((process-launched (or (ad-get-arg 2) ; corresponds to `new`
                              (not (comint-check-proc python-buffer)))))
    (flet ((sit-for (seconds &optional nodisp)
                    (when process-launched
                      (accept-process-output (get-buffer-process python-buffer)))))
      ad-do-it)))

(autoload 'helm-pydoc "helm-pydoc" nil t)

(eval-after-load "python"
  '(progn
     ;; binding
     (define-key python-mode-map (kbd "C-c C-a") 'helm-pydoc)
     (define-key python-mode-map (kbd "C-c C-z") 'run-python)
     (define-key python-mode-map (kbd "<backtab>") 'python-back-indent)))

(eval-after-load "jedi"
  '(progn
     ;; binding
     (define-key python-mode-map (kbd "C-c C-d") 'jedi:show-doc)
     (define-key python-mode-map (kbd "C-c C-l") 'jedi:get-in-function-call)

     ;; show-doc
     (setq jedi:tooltip-method nil)
     (set-face-attribute 'jedi:highlight-function-argument nil
                         :foreground "green")))

(defun my/python-mode-hook ()
  (setq python-indent 4)
  (jedi:setup)

  ;; flycheck
  (setq flycheck-checker 'python-flake8
        flycheck-flake8rc (expand-file-name "~/.config/flake8"))

  ;; autopair
  (setq autopair-handle-action-fns
        '(autopair-default-handle-action autopair-python-triple-quote-action)))

(add-hook 'python-mode-hook 'my/python-mode-hook)
