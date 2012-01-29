;; setting haskell language
(add-to-list 'load-path "~/.emacs.d/haskell-mode")
(add-to-list 'load-path "~/.emacs.d/ghc-mod")
(setq ghc-module-command "~/.cabal/bin/ghc-mod")

(load "~/.emacs.d/haskell-mode/haskell-site-file")

(when (require 'ghc nil t)
  (autoload 'ghc-init "ghc" nil t))

(add-to-list 'auto-mode-alist
         '("\\.\\(hs\\|hi\\|gs\\)$" . haskell-mode))

(defun haskell-individual-setup ()
  (let ((mapping '(([f5] . "\C-c\C-l\C-x\omain\C-m\C-xo")
                   ("\C-c\C-i" . ghc-complete)
                   ([backtab] . haskell-indent-cycle))))
    (loop for (key . f) in mapping
          do (define-key haskell-mode-map key f))
    (turn-on-haskell-doc-mode)
    (turn-on-haskell-indent)
    (imenu-add-menubar-index)
    (ghc-init)
    (flymake-mode)))

(add-hook 'haskell-mode-hook 'haskell-individual-setup)
