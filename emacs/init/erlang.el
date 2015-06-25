;; erlang
(eval-after-load "erlang"
  '(progn
     (require 'erlang-start)
     (require 'erlang-flymake)))

(defun my/erlang-mode-hook ()
  (setq erlang-electric-commands '(erlang-electric-comma erlang-electric-semicolon))
  (setq erlang-electric-newline-inhibit-list '(erlang-electric-gt))
  (setq erlang-electric-newline-inhibit t))
(add-hook 'erlang-mode-hook 'my/erlang-mode-hook)

;; distel
;;(add-to-list 'load-path (concat user-emacs-directory "elisps/distel/elisp/")
;;(require 'distel)
;;(distel-setup)
