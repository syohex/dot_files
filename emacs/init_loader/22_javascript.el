;; setting for javascript
(eval-after-load "js"
  '(progn
     (setq-default js-auto-indent-flag nil)))

(defun my/js-mode-hook ()
  (setq flycheck-checker 'javascript-jshint))
(add-hook 'js-mode-hook 'my/js-mode-hook)

;; coffeescript
(eval-after-load "coffee-mode"
  '(progn
     (setq coffee-tab-width 2)))

(defun my/coffee-mode-hook ()
  (setq flycheck-checker 'coffee)
  (local-unset-key (kbd "C-m")))

(add-hook 'coffee-mode-hook 'my/coffee-mode-hook)
