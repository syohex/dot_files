;; setting for diff-mode and ediff
(with-eval-after-load 'diff-mode
  ;; key bindings
  (define-key diff-mode-map (kbd "C-M-n") 'diff-file-next)
  (define-key diff-mode-map (kbd "C-M-p") 'diff-file-prev))

;; ediff
(custom-set-variables
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-diff-options "-twB"))
