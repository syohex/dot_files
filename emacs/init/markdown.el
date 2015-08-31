;; setting markdown-mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(custom-set-variables
 '(markdown-indent-on-enter nil))

(with-eval-after-load 'markdown-mode
  ;; key bindings
  (define-key markdown-mode-map (kbd "C-M-i") 'auto-complete)
  ;;(define-key markdown-mode-map (kbd "C-M-i") 'company-complete)

  (define-key markdown-mode-map (kbd "C-c C-n") 'outline-next-visible-heading)
  (define-key markdown-mode-map (kbd "C-c C-p") 'outline-previous-visible-heading)
  (define-key markdown-mode-map (kbd "C-c C-f") 'outline-forward-same-level)
  (define-key markdown-mode-map (kbd "C-c C-b") 'outline-backward-same-level)
  (define-key markdown-mode-map (kbd "C-c C-u") 'outline-up-heading)
  (define-key markdown-mode-map (kbd "C-c C-c C-l") 'markdown-insert-link)

  (define-key gfm-mode-map (kbd "C-c C-c C-c") 'markdown-insert-gfm-code-block)
  (define-key gfm-mode-map (kbd "`") nil))

(defun my/markdown-mode-hook ()
  (make-local-variable 'electric-pair-text-pairs)
  (add-to-list 'electric-pair-text-pairs '(?` . ?`))
  (setq-local tab-width 8))
(add-hook 'markdown-mode-hook 'my/markdown-mode-hook t)
