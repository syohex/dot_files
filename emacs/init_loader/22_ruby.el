;; setting for ruby
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

(autoload 'ruby-mode "ruby-mode")

;; inf-ruby.el
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map (kbd "<tab>") 'yas/expand)
             (inf-ruby-keys)))

(setq ruby-deep-indent-paren nil)

;; ruby-electric.el --- electric editing commands for ruby files
(autoload 'ruby-mode "ruby-electric" nil t)
(eval-after-load "ruby-electric"
  '(progn
     (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
     (setq ruby-electric-expand-delimiters-list '())))

;; rcodetools
(add-to-list 'load-path "~/.emacs.d/rcodetools")
(autoload 'ruby-mode "rcodetools" nil t)
(autoload 'ruby-mode "anything-rcodetools")
(eval-after-load "rcodetools"
  '(progn
     (define-key ruby-mode-map (kbd "C-j") 'rct-complete-symbol--anything)))

;; flymake
;; (install-elisp "https://raw.github.com/purcell/flymake-ruby/master/flymake-ruby.el")
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
