;; mozc
(setq is-setup-mozc nil)

 ;; This value should be set before loading `mozc.el'
(setq mozc-leim-title "[も]")

(when (require 'mozc nil t)
  (setq is-setup-mozc t)
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'overlay)

  ;; faces
  (set-face-attribute 'mozc-cand-overlay-even-face 'nil
                      :background "aquamarine" :foreground "black")
  (set-face-attribute 'mozc-cand-overlay-odd-face 'nil
                      :background "aquamarine" :foreground "black")

  (global-set-key (kbd "C-o") 'toggle-input-method))

;; anthy
(when (and (not is-setup-mozc) (require 'anthy nil t))
  (global-set-key "\C-o" 'anthy-mode)
  (setq default-input-method "japanese-anthy")
  ;; for emacs 23
  (setq anthy-accept-timeout 1)
  (setq anthy-wide-space " ")
  ;; anthy-mode-map
  (define-key anthy-mode-map (kbd "C-j") 'dabbrev-expand)
  (if (not window-system)
      (progn
        (set-face-foreground 'anthy-highlight-face "white")
        (set-face-background 'anthy-highlight-face "color-59")
        (set-face-background 'highlight            "color-53"))))
