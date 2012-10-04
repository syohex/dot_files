;; setting for ruby
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;; inf-ruby.el
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq ruby-deep-indent-paren nil)
             (ruby-end-mode)
             (flymake-ruby-load)

             ;; indentation
             (setq ruby-deep-indent-paren nil)
             (defadvice ruby-indent-line (after unindent-closing-paren activate)
               (let ((column (current-column))
                     (indent nil)
                     (offset 0))
                 (save-excursion
                   (back-to-indentation)
                   (let ((state (syntax-ppss)))
                     (setq offset (- column (current-column)))
                     (when (and (eq (char-after) ?\))
                                (not (zerop (car state))))
                       (goto-char (cadr state))
                       (setq indent (current-indentation)))))
                 (when indent
                   (indent-line-to indent)
                   (and (> offset 0) (forward-char offset)))))

             ;; auto insert pair
             (require 'ruby-electric)
             (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
             (setq ruby-electric-expand-delimiters-list nil)

             ;; rsense
             (setq rsense-home (expand-file-name "~/.emacs.d/rsense"))
             (add-to-list 'load-path (concat rsense-home "/etc"))
             (require 'rsense)
             (add-to-list 'ac-sources ac-source-rsense-method)
             (add-to-list 'ac-sources ac-source-rsense-constant)

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
