;; configuration of spell check
(with-eval-after-load 'ispell
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

;; flyspell
(with-eval-after-load 'flyspell
  (define-key flyspell-mode-map (kbd "C-M-i") nil))
