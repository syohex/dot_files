;; show paren
(show-paren-mode 1)
(setq show-paren-delay 0
      show-paren-style 'expression)
(when window-system
  (set-face-attribute 'show-paren-match-face nil
                      :background nil :foreground nil
                      :underline "#ffff00" :weight 'extra-bold))
