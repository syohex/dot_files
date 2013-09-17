;; erlang
(eval-after-load "erlang"
  '(progn
     (require 'erlang-start)
     (require 'erlang-flymake)

     ;; distel
     (add-to-list 'load-path (concat user-emacs-directory "elisps/distel/elisp/"))

     (require 'distel)
     (distel-setup)))
