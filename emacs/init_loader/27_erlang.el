;; erlang-mode
(add-to-list 'load-path "~/.emacs.d/erlang-mode")
(setq erlang-root-dir "/usr/local")
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))

(autoload 'erlang-mode "erlang")
(eval-after-load "erlang"
  '(progn
     (require 'erlang-start)))

;; elixir
(autoload 'elixir-mode "elixir-mode" nil t)
