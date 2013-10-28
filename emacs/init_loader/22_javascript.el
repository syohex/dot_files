;; setting for javascript
(defalias 'javascript-generic-mode 'js-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(setq-default js-auto-indent-flag nil)
(add-hook 'js-mode-hook 'flymake-jslint-load)

;; coffeescript
(eval-after-load "coffee-mode"
  '(progn
     (setq coffee-tab-width 2)))

(defun my/coffee-mode-hook ()
  (local-unset-key (kbd "C-m")))

(add-hook 'coffee-mode-hook 'my/coffee-mode-hook)
