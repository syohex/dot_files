;; Io programming language
(autoload 'io-mode "io-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.io$" . io-mode))

(eval-after-load "io-mode"
  '(progn
     (setq io-tab-width 4)))
