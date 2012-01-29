;; setting for scheme
(setq scheme-program-name "gosh")
(require 'cmuscheme)

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(define-key scheme-mode-map (kbd "C-c S") 'scheme-other-window)
(push '("*scheme*" :stick t) popwin:special-display-config)
