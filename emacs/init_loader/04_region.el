;;;; region setting

;; wrap-region
(require 'wrap-region)
(wrap-region-global-mode t)

(defun my/wrap-region-zero-width ()
  (let ((region-size (- (region-end) (region-beginning)))
        (wrapper (wrap-region-find (char-to-string last-input-event))))
    (when (and (zerop region-size) wrapper)
      (let ((left (wrap-region-wrapper-left wrapper)))
        (forward-char (length left))))))

(add-hook 'wrap-region-after-wrap-hook 'my/wrap-region-zero-width)

;; disable paredit enable mode
(add-to-list 'wrap-region-except-modes 'emacs-lisp-mode)
(add-to-list 'wrap-region-except-modes 'scheme-mode)
(add-to-list 'wrap-region-except-modes 'lisp-mode)
(add-to-list 'wrap-region-except-modes 'clojure-mode)
