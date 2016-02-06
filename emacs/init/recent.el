;;;; recentf-ext
(custom-set-variables
 '(recentf-max-saved-items 2000)
 '(recentf-auto-cleanup 600)
 '(recentf-exclude '("recentf" "/elpa/" "/elisps/" "\\`/tmp/" "/\\.git/" "/\\.cask/"
                     "/tmp/gomi/" "/el-get/" ".loaddefs.el" "/\\.cpanm/"
                     "\\.mime-example" "\\.ido.last" "woman_cache.el"
                     "\\`/proc/" "\\`/sys/"
                     "CMakeCache.txt" "/bookmarks" "\\.gz$"
                     "COMMIT_EDITMSG" "MERGE_MSG" "git-rebase-todo")))

(run-at-time t 600 #'editutil-recentf-save-list)
(recentf-mode 1)
