;; configuration of spell check
(eval-after-load "ispell"
  '(progn
     (setq-default ispell-program-name "aspell")
     (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))     ))

;; flyspell
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mode-map (kbd "M-n") 'flyspell-goto-next-error)
     (define-key flyspell-mode-map (kbd "M-.") 'ispell-word)))

(add-to-list 'auto-mode-alist '("Changes\\'" . flyspell-mode))
