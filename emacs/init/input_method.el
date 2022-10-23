;; change cursor color 'enable input method' / 'disable input method'
(defun my/input-method-active-hook ()
  (when (memq major-mode my/electric-pair-enabled-modes)
    (electric-pair-local-mode -1))
  (set-cursor-color "gold"))

(defun my/input-method-inactivate-hook ()
  (when (memq major-mode my/electric-pair-enabled-modes)
    (electric-pair-local-mode +1))
  (set-cursor-color "chartreuse2"))

(add-hook 'input-method-activate-hook 'my/input-method-active-hook)
(add-hook 'input-method-deactivate-hook 'my/input-method-inactivate-hook)

;; This value should be set before loading `mozc.el'
(custom-set-variables
 '(mozc-candidate-style 'echo-area) ;; overlay is too slow
 '(mozc-leim-title "[も]"))

(when (and (require 'mozc nil t) (executable-find "mozc_emacs_helper"))
  (setq default-input-method "japanese-mozc")
  (global-set-key (kbd "C-o") 'toggle-input-method))
