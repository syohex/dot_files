;; setting of bookmark
(require 'bookmark)
(setq bookmark-save-flag t)

(defun my/anything-bookmark ()
  (interactive)
  (anything-other-buffer
   '(
     anything-c-source-bookmarks)
   " *anything-bookmark*"))

(define-key ctl-x-r-map (kbd "b") 'my/anything-bookmark)
