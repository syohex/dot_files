;; change cursor color 'enable input method' / 'disable input method'
(defun my/input-method-active-hook ()
  (when (and (memq major-mode my/smartparens-enabled-modes)
             smartparens-mode)
    (smartparens-mode -1))
  (set-cursor-color "gold"))

(defun my/input-method-inactivate-hook ()
  (when (and (not smartparens-mode)
             (memq major-mode my/smartparens-enabled-modes))
    (smartparens-mode +1))
  (set-cursor-color "chartreuse2"))

(add-hook 'input-method-activate-hook 'my/input-method-active-hook)
(add-hook 'input-method-inactivate-hook 'my/input-method-inactivate-hook)
