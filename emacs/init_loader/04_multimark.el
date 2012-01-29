;; setting for multimark
;; (shell-command "cd ~/.emacs.d && git clone https://github.com/magnars/mark-multiple.el.git")
(add-to-list 'load-path "~/.emacs.d/mark-multiple.el")

(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
