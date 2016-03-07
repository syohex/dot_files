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
  ;; robe-eldoc often display wrong information
  (setq-local eldoc-documentation-function nil)
  ;;(add-to-list 'ac-sources 'ac-source-robe)
  (setq-local company-backends '(company-robe company-dabbrev))

  ;; auto insert `end'
  (ruby-end-mode +1))
