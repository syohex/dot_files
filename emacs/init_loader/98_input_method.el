;; mozc

;; This value should be set before loading `mozc.el'
(setq mozc-leim-title "[も]")

;; change cursor color 'enable input method' / 'disable input method'
(add-hook 'input-method-activate-hook '(lambda () (set-cursor-color "gold")))
(add-hook 'input-method-inactivate-hook '(lambda () (set-cursor-color "chartreuse2")))

(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'overlay)

  ;; faces
  (set-face-attribute 'mozc-cand-overlay-even-face 'nil
                      :background "aquamarine" :foreground "black")
  (set-face-attribute 'mozc-cand-overlay-odd-face 'nil
                      :background "aquamarine" :foreground "black")

  ;; key
  (define-key mozc-mode-map (kbd "C-c C-o") 'my/toggle-mozc-style)

  (global-set-key (kbd "C-o") 'toggle-input-method))

(defun my/toggle-mozc-style ()
  (interactive)
  (if (eq mozc-candidate-style 'echo-area)
      (setq mozc-candidate-style 'overlay)
    (setq mozc-candidate-style 'echo-area)))
