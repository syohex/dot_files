;; setting markdown-mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(custom-set-variables
 '(markdown-indent-on-enter nil)
 '(markdown-gfm-use-electric-backquote nil)
 '(markdown-make-gfm-checkboxes-buttons))

(with-eval-after-load 'markdown-mode
  ;; key bindings
  (define-key markdown-mode-map (kbd "C-M-i") 'company-complete))

(defun my/markdown-mode-hook ()
  (setq-local company-backends '(company-ispell company-files company-dabbrev))
  (make-local-variable 'electric-pair-pairs)
  (add-to-list 'electric-pair-pairs '(?` . ?`))
  (setq-local tab-width 8))
(add-hook 'markdown-mode-hook 'my/markdown-mode-hook t)
