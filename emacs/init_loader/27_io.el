;; Io programming language
;; git clone https://github.com/superbobry/io-mode.git ~/.emacs.d
;; git clone https://github.com/slackorama/io-emacs.git ~/.emacs.d
(add-to-list 'load-path "~/.emacs.d/io-mode")
(add-to-list 'load-path "~/.emacs.d/io-emacs")
(require 'io-mode)
(require 'io-mode-inf)

(add-to-list 'auto-mode-alist '("\\.io$" . io-mode))
(setq io-tab-width 4)
