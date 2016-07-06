;; setting for javascript
(custom-set-variables
 '(js-auto-indent-flag nil))

(defun my/js-mode-hook ()
  (setq-local company-backends '(company-tern company-dabbrev))
  (setq flycheck-checker 'javascript-jshint))
(add-hook 'js-mode-hook #'my/js-mode-hook)

(defun my/json-mode-hook ()
  (setq flycheck-checker 'json-jsonlint))
(add-hook 'json-mode-hook #'my/json-mode-hook)
