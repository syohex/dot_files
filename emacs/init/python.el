;; python-setting

(defun my/python-mode-hook ()
  (jedi:setup)
  (setq-local company-backends '(company-jedi company-dabbrev))

  ;; flycheck
  (setq flycheck-flake8rc (expand-file-name "~/.config/flake8")))

(with-eval-after-load 'python
  (add-hook 'python-mode-hook 'my/python-mode-hook)

  ;; binding
  (define-key python-mode-map (kbd "C-M-i") 'company-complete)
  (define-key python-mode-map (kbd "C-c C-h") 'jedi:show-doc)
  (define-key python-mode-map (kbd "C-c C-l") 'jedi:get-in-function-call)

  (smartrep-define-key
      python-mode-map "C-c" '(("h" . 'python-indent-shift-left)
                              ("l" . 'python-indent-shift-right))))

;; jedi
(custom-set-variables
 '(jedi:tooltip-method nil))
