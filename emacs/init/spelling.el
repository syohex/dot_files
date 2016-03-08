;; configuration of spell check
(custom-set-variables
 '(flyspell-use-meta-tab nil))

(with-eval-after-load 'ispell
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
