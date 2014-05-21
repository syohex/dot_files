;; setting markdown-mode
(custom-set-variables
 '(markdown-command "Markdown.pl"))

(eval-after-load "markdown-mode"
  '(progn
     ;; key bindings
     (define-key markdown-mode-map (kbd "C-M-f") 'forward-symbol)
     (define-key markdown-mode-map (kbd "C-M-b") 'editutil-backward-symbol)
     (define-key markdown-mode-map (kbd "C-M-u") 'editutil-backward-up)

     (define-key markdown-mode-map (kbd "C-c C-n") 'outline-next-visible-heading)
     (define-key markdown-mode-map (kbd "C-c C-p") 'outline-previous-visible-heading)
     (define-key markdown-mode-map (kbd "C-c C-f") 'outline-forward-same-level)
     (define-key markdown-mode-map (kbd "C-c C-b") 'outline-backward-same-level)
     (define-key markdown-mode-map (kbd "C-c C-u") 'outline-up-heading)))
