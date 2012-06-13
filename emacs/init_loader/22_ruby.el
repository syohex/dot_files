;; setting for ruby
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;; inf-ruby.el
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq ruby-deep-indent-paren nil)
             (ruby-end-mode)
             (flymake-ruby-load)

             ;; rsense
             (setq rsense-home (expand-file-name "~/.emacs.d/rsense"))
             (add-to-list 'load-path (concat rsense-home "/etc"))
             (require 'rsense)
             (add-to-list 'ac-sources ac-source-rsense-method)
             (add-to-list 'ac-sources ac-source-rsense-constant)

             (define-key ruby-mode-map (kbd "<tab>") 'yas/expand)
             (define-key ruby-mode-map (kbd "C-M-i") 'auto-complete)

             ;;;; yari
             (require 'yari)
             (define-key ruby-mode-map (kbd "C-c C-d") 'yari-anything)))

;; flymake
(autoload 'flymake-ruby-load "flymake-ruby")
