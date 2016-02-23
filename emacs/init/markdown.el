;; setting markdown-mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(custom-set-variables
 '(markdown-indent-on-enter nil)
 '(markdown-make-gfm-checkboxes-buttons))

(with-eval-after-load 'markdown-mode
  ;; key bindings
  ;;(define-key markdown-mode-map (kbd "C-M-i") 'auto-complete)
  (define-key markdown-mode-map (kbd "C-M-i") 'company-complete)

  (define-key markdown-mode-map (kbd "C-c C-c C-l") 'markdown-insert-link)
  (define-key markdown-mode-map (kbd "C-c C-c C-i") 'markdown-insert-image)

  (define-key gfm-mode-map (kbd "C-c C-c C-c") 'markdown-insert-gfm-code-block)
  (define-key gfm-mode-map (kbd "`") nil))

(defun my/markdown-mode-hook ()
  (setq-local company-backends '(company-ispell company-files company-dabbrev))
  (make-local-variable 'electric-pair-pairs)
  (add-to-list 'electric-pair-pairs '(?` . ?`))
  (setq-local tab-width 8))
(add-hook 'markdown-mode-hook 'my/markdown-mode-hook t)
