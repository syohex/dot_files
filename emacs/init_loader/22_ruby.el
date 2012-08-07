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

             ;;;; yari
             (require 'yari)
             (define-key ruby-mode-map (kbd "C-c C-d") 'yari-helm)))

(defvar yari-helm-source-ri-pages
  '((name . "RI documentation")
    (candidates . (lambda () (yari-ruby-obarray)))
    (action  ("Show with Yari" . yari))
    (candidate-number-limit . 300)
    (requires-pattern . 2)
    "Source for completing RI documentation."))

(defun yari-helm (&optional rehash)
  (interactive (list current-prefix-arg))
  (when current-prefix-arg (yari-ruby-obarray rehash))
  (helm :sources 'yari-helm-source-ri-pages :buffer "*yari*"))

;; flymake
(autoload 'flymake-ruby-load "flymake-ruby")
