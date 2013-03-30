;; mozc

;; change cursor color 'enable input method' / 'disable input method'
(defun my/input-method-active-hook ()
  (when (memq major-mode my/autopair-enabled-modes)
    (autopair-mode -1))
  (set-cursor-color "gold"))

(defun my/input-method-inactivate-hook ()
  (when (memq major-mode my/autopair-enabled-modes)
    (autopair-mode t))
  (set-cursor-color "chartreuse2"))

(add-hook 'input-method-activate-hook 'my/input-method-active-hook)
(add-hook 'input-method-inactivate-hook 'my/input-method-inactivate-hook)

(when (linux-p)
  ;; This value should be set before loading `mozc.el'
  (setq mozc-leim-title "[も]")
  (require 'mozc)
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'echo-area) ;; overlay is too slow
  (global-set-key (kbd "C-o") 'toggle-input-method))
