;; configuration of spell check
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

;; flyspell
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mode-map (kbd "C-M-i") nil)))
