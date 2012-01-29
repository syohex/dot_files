;; setting for ruby
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;; inf-ruby.el
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)))

(setq ruby-deep-indent-paren nil)

;; ruby-electric.el --- electric editing commands for ruby files
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list '())

(define-key ruby-mode-map (kbd "<tab>") 'yas/expand)

;; rcodetools
(add-to-list 'load-path "~/.emacs.d/rcodetools")
(when (require 'rcodetools nil t)
  (require 'anything-rcodetools)
  (define-key ruby-mode-map (kbd "C-j") 'rct-complete-symbol--anything))
