;; wanderlust
(when (require 'wl nil t)
  (load "mime-setup")
  (autoload 'wl "wl" "Wanderlust" t)
  (autoload 'wl-draft "wl" "write draft Wanderlust." t)

  ;; w3m, viewing HTML mail
  (require 'w3m-load nil t)
  (require 'mime-w3m nil t)
  (setq mine-w3m-display-inline-images t))
