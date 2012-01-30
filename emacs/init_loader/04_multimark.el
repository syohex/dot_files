;; setting for multimark
(add-to-list 'load-path "~/.emacs.d/repos/mark-multiple.el")

;;(require 'inline-string-rectangle)
;;(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
