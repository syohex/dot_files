;;;; recentf-ext
(custom-set-variables
 '(recentf-max-saved-items 2000)
 '(recentf-auto-cleanup 600)
 '(recentf-exclude '(".recentf" "/elpa/" "/elisps/" "^/tmp/" "/\\.git/" "/\\.cask/"
                     "\\.mime-example" "\\.ido.last" "woman_cache.el"
                     "COMMIT_EDITMSG" "MERGE_MSG" "bookmarks" "\\.gz$")))

(run-at-time t 600 'recentf-save-list)
(recentf-mode 1)
