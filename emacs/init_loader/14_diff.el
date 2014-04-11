;; setting for diff-mode and ediff
(add-hook 'diff-mode-hook 'read-only-mode)
(eval-after-load "diff-mode"
  '(progn
     (set-face-attribute 'diff-added-face nil
                         :background nil :foreground "green"
                         :weight 'normal)
     (set-face-attribute 'diff-removed-face nil
                         :background nil :foreground "firebrick1"
                         :weight 'normal)

     (set-face-attribute 'diff-file-header-face nil
                         :background nil :weight 'extra-bold)

     (set-face-attribute 'diff-refine-change nil
                         :background nil)

     (set-face-attribute 'diff-header-face nil
                         :background nil :weight 'extra-bold)
     (set-face-attribute 'diff-hunk-header-face nil
                         :foreground "turquoise"
                         :weight 'extra-bold
                         :underline t)
     ;; key bindings
     (define-key diff-mode-map (kbd "C-M-n") 'diff-file-next)
     (define-key diff-mode-map (kbd "C-M-p") 'diff-file-prev)))

;; ediff
(custom-set-variables
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-diff-options "-twB"))
