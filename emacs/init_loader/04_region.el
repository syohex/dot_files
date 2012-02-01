;;;; region setting

;; wrap-region
(require 'wrap-region)
(wrap-region-global-mode t)
(add-to-list 'wrap-region-except-modes 'emacs-lisp-mode)
