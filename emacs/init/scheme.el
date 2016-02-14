;; setting for scheme
(custom-set-variables
 '(scheme-program-name "gosh"))

(with-eval-after-load "scheme"
  (require 'cmuscheme)
  (require 'helm-info)
  (push '("*scheme*" :stick t) popwin:special-display-config)
  (define-key scheme-mode-map (kbd "C-c C-z") 'run-scheme)
  (define-key scheme-mode-map (kbd "C-c C-c") 'scheme-send-definition)
  (define-key scheme-mode-map (kbd "C-c C-e") 'scheme-send-definition-and-go)
  (define-key scheme-mode-map (kbd "C-c C-d") 'helm-info-gauche-refe))
