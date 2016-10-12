;; setting haskell language
(with-eval-after-load 'haskell-mode
  (require 'haskell-simple-indent)
  (require 'ghc)

  (add-hook 'haskell-mode-hook 'my/haskell-mode-hook)

  ;; ghc
  (setq ghc-module-command (executable-find "ghc-mod"))

  ;; bindings
  (define-key haskell-mode-map (kbd "C-c C-d") 'helm-editutil-ghc-browse-document)
  (define-key haskell-mode-map (kbd "M-o") 'editutil-edit-next-line-same-column)
  (define-key haskell-mode-map (kbd "TAB") 'haskell-simple-indent)
  (define-key haskell-mode-map (kbd "<backtab>") 'haskell-simple-indent-backtab)
  (define-key haskell-mode-map [remap newline] 'haskell-simple-indent-newline-same-col)
  (define-key haskell-mode-map [remap newline-and-indent] 'haskell-simple-indent-newline-indent)
  (define-key haskell-mode-map (kbd "C-<return>") 'haskell-simple-indent-newline-indent))

(defun my/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indent)

  ;; I don't want to set key bindings
  (ghc-abbrev-init)
  (ghc-type-init)
  (unless ghc-initialized
    (ghc-comp-init)
    (setq ghc-initialized t))

  ;; for auto-complete
  (add-to-list 'ac-sources 'ac-source-ghc-mod))

;; Wrap region with block comment
(defun haskell-block-commend-region (start end)
  (interactive "r")
  (save-excursion
    (let (end-marker)
      (goto-char end)
      (setq end-marker (point-marker))
      (goto-char start)
      (insert "{-\n")
      (goto-char (marker-position end-marker))
      (insert "-}"))))
