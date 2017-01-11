;;;; setting about `buffer'

;; naming of same name file
(require 'uniquify)
(custom-set-variables
 '(uniquify-buffer-name-style 'post-forward-angle-brackets))

(with-eval-after-load 'bs
  (fset 'bs-message-without-log 'ignore))
