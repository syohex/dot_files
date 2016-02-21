;; setting for scheme
(with-eval-after-load "scheme"
  (require 'cmuscheme)
  (require 'helm-info)

  (progutil-scheme-setup 'gauche)

  (push '("*scheme*" :stick t) popwin:special-display-config)
  (define-key scheme-mode-map (kbd "C-c C-z") 'run-scheme)
  (define-key scheme-mode-map (kbd "C-c C-c") 'scheme-send-definition)
  (define-key scheme-mode-map (kbd "C-c C-e") 'scheme-send-definition-and-go)
  (define-key scheme-mode-map (kbd "C-c C-d") 'helm-info-gauche-refe))
