;; skype for emacs
(add-to-list 'load-path "~/src/emacs-skype")
(when (require 'skype nil t)
  (setq skype--my-user-handle "syohex")
  (global-set-key (kbd "M-9") 'skype--anything-command))
