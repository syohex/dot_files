;; setting for javascript
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(setq-default js-auto-indent-flag nil)
(add-hook 'js-mode-hook 'flymake-jslint-load)
