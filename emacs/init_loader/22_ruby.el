;; setting for ruby
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(add-to-list 'load-path "~/.emacs.d/rcodetools")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;;(autoload 'ruby-mode "ruby-mode")
;;(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process" t)
;;(autoload 'inf-ruby-keys "inf-ruby" "" t)

;; inf-ruby.el
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq ruby-deep-indent-paren nil)
             (ruby-end-mode)
             (flymake-ruby-load)

             ;; rsense
             (setq rsense-home (expand-file-name "~/.emacs.d/rsense"))
             ;; rurema
             (setq rsense-rurema-home "~/src/rurema")
             (custom-set-variables
              '(rsense-rurema-refe "refe-1_9_2"))
             (add-to-list 'load-path (concat rsense-home "/etc"))
             (require 'rsense)
             (add-to-list 'ac-sources ac-source-rsense-method)
             (add-to-list 'ac-sources ac-source-rsense-constant)

             (define-key ruby-mode-map (kbd "<tab>") 'yas/expand)
             (define-key ruby-mode-map (kbd "C-M-i") 'auto-complete)
             (define-key ruby-mode-map (kbd "C-c d") 'refe2)

             ;;;; yari
             (require 'yari)
             (define-key ruby-mode-map (kbd "C-c C-d") 'yari-anything)))

(defvar refe2-buffer "*refe2*")
(defun refe2 (cmd)
  (interactive "sRefe2: ")
  (if (= (call-process-shell-command (concat "refe2 " cmd) nil refe2-buffer) 0)
      (pop-to-buffer refe2-buffer)
    (message "Not found: '%s' document" cmd)))
(push '("*refe2*" :stick t) popwin:special-display-config)

;; flymake
(autoload 'flymake-ruby-load "flymake-ruby")
