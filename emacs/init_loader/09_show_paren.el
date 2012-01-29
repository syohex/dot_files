;; show paren
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(when window-system
  (set-face-attribute 'show-paren-match-face nil
                      :background nil :foreground nil
                      :underline "#ffff00" :weight 'extra-bold))

(when (not window-system)
  (set-face-background 'show-paren-match-face nil)
  (set-face-foreground 'show-paren-match-face nil)
  (set-face-underline  'show-paren-match-face "#ffff00")
  (set-face-bold-p 'show-paren-match-face 'extra-bold))
