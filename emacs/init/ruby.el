;; setting for ruby
(custom-set-variables
 '(ruby-deep-indent-paren nil)
 '(ruby-insert-encoding-magic-comment nil)
 '(robe-completing-read-func #'helm-robe-completing-read)
 '(robe-highlight-capf-candidates nil))

(with-eval-after-load 'ruby-mode
  (progutil-ruby-setup)

  (add-hook 'ruby-mode-hook 'my/ruby-mode-hook)
  ;; rbenv
  ;;(global-rbenv-mode t) ;; I think it may not be needed

  ;; binding
  (define-key ruby-mode-map (kbd "C-c C-a") 'ruby-beginning-of-block)
  (define-key ruby-mode-map (kbd "C-c C-e") 'ruby-end-of-block)
  (define-key ruby-mode-map (kbd "C-c ?") 'robe-doc)

  ;; disable default bindings
  (dolist (key '("(" ")" "{" "}" "[" "]" "\"" "'"))
    (define-key ruby-mode-map key nil)))

(defun my/ruby-mode-hook ()
  (setq flycheck-checker 'ruby-rubocop)

  ;; robe
  (robe-mode +1)
  (add-to-list 'ac-sources 'ac-source-robe)
  ;;(add-to-list 'company-backends 'company-robe)

  ;; auto insert `end'
  (ruby-end-mode +1))
