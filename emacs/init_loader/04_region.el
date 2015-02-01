;;;; region setting
;; wrap-region
(wrap-region-global-mode +1)

;; add wrappers
(wrap-region-add-wrapper "`" "`")
(wrap-region-add-wrapper "{" "}")

;; disable paredit enable mode
(dolist (mode (append '(emacs-lisp-mode scheme-mode lisp-mode clojure-mode)
                      my/autopair-enabled-modes))
  (add-to-list 'wrap-region-except-modes mode))
