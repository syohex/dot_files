;; wanderlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-draft "wl" "write draft Wanderlust." t)

(eval-after-load "wl"
  '(progn
     (load "mime-setup")
     (require 'w3m-load nil t)
     (require 'mime-w3m nil t)

     (setq mine-w3m-display-inline-images t)))

(add-hook 'wl-draft-mode-hook
          '(lambda ()
             (wrap-region-mode)
             (yas/minor-mode)))
