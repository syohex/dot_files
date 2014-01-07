;; wanderlust
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-draft "wl" "write draft Wanderlust." t)

(eval-after-load "wl"
  '(progn
     (load "mime-setup")
     (require 'elscreen-wl)))

(defun my/wl-draft-mode-hook ()
  (wrap-region-mode)
  (yas/minor-mode))

(add-hook 'wl-draft-mode-hook 'my/wl-draft-mode-hook)
