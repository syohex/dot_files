;; setting for javascript
(custom-set-variables
 '(js-auto-indent-flag nil))

(defun my/js-mode-hook ()
  (setq flycheck-checker 'javascript-jshint))
(add-hook 'js-mode-hook 'my/js-mode-hook)
