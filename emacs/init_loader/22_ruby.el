;; setting for ruby
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(add-to-list 'load-path "~/.emacs.d/rcodetools")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

(autoload 'ruby-mode "ruby-mode")

;; inf-ruby.el
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (ruby-electric-mode t)
             (flymake-ruby-load)
             (inf-ruby-keys)

             ;; rsense
             (setq rsense-home (expand-file-name "~/.emacs.d/rsense"))
             (add-to-list 'load-path (concat rsense-home "/etc"))
             (require 'rsense)
             (add-to-list 'ac-sources ac-source-rsense-method)
             (add-to-list 'ac-sources ac-source-rsense-constant)

             (define-key ruby-mode-map (kbd "<tab>") 'yas/expand)
             (define-key ruby-mode-map (kbd "C-<return>") 'auto-complete)

             ;;;; yari
             ;;  (auto-install-from-url "http://www.emacswiki.org/emacs/download/yari.el")
             (require 'yari)
             (define-key ruby-mode-map (kbd "C-c C-d") 'yari-anything)))

(setq ruby-deep-indent-paren nil)

;; ruby-electric.el --- electric editing commands for ruby files
(autoload 'ruby-electric-mode "ruby-electric" nil t)
(eval-after-load "ruby-electric"
  '(progn
     (setq ruby-electric-expand-delimiters-list '())))

;; flymake
;; (auto-install-from-url "https://raw.github.com/purcell/flymake-ruby/master/flymake-ruby.el")
(autoload 'flymake-ruby-load "flymake-ruby")
