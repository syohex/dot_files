;; setting for javascript
(custom-set-variables
 '(js-auto-indent-flag nil))

(defun my/js-mode-hook ()
  (setq flycheck-checker 'javascript-jshint))
(add-hook 'js-mode-hook 'my/js-mode-hook)

;; coffeescript
(custom-set-variables
 '(coffee-tab-width 2))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [remap newline-and-indent] 'nil)
     (define-key coffee-mode-map (kbd "C-m") 'nil)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

(defun my/coffee-mode-hook ()
  (setq flycheck-checker 'coffee))

(add-hook 'coffee-mode-hook 'my/coffee-mode-hook)
