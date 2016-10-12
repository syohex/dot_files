;; setting for javascript
(custom-set-variables
 '(js-auto-indent-flag nil))

(defun my/js-mode-hook ()
  (setq-local company-backends '(company-tern company-dabbrev)))
(add-hook 'js-mode-hook #'my/js-mode-hook)
