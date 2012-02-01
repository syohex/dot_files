;;;; region setting

;; wrap-region
(require 'wrap-region)
(wrap-region-mode t)
(add-to-list 'wrap-region-except-modes 'paredit-mode)
