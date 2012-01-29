;; highlight
(if window-system
    (progn
      (global-hl-line-mode)
      (set-face-background 'hl-line "grey40"))
  (progn
    (global-hl-line-mode)
    (setq hl-line-face 'underline)))

(global-set-key [f7] 'global-hl-line-mode)

;; hi-lock
(require 'hi-lock)
(global-hi-lock-mode 1)
