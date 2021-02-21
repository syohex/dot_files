;; configuration of spell check
(custom-set-variables
 '(flyspell-issue-welcome-flag nil)
 '(flyspell-use-meta-tab nil))

(with-eval-after-load 'ispell
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))
  (when (and ispell-program-name
             (and (string= (file-name-nondirectory ispell-program-name) "aspell")))
    (setq ispell-extra-args '("--lang=en_US" "--camel-case"))))
