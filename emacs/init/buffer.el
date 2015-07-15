;;;; setting about `buffer'

;; naming of same name file
(require 'uniquify)
(custom-set-variables
 '(uniquify-buffer-name-style 'post-forward-angle-brackets))

;; use ibuffer instead of list-buffer
(defalias 'list-buffers 'ibuffer)

(global-set-key (kbd "M-9") 'bs-cycle-next)
(global-set-key (kbd "M-0") 'bs-cycle-previous)

(defun my/save-buffer ()
  (save-buffer))
(add-hook 'focus-out-hook 'my/save-buffer)
