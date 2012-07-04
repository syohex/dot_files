;;;; color-moccur
(require 'color-moccur)
(setq moccur-split-word t)
(setq split-window-threshold 'nil)
(setq moccur-following-mode-toggle t)
(setq moccur-kill-moccur-buffer t)

(global-set-key (kbd "M-g M-m") 'moccur)

;; moccur-edit
(require 'moccur-edit)

;; dmoccur ignore list
(setq dmoccur-exclusion-mask
      (append '("\\~$"
                "\\.svn\\/\*"
                "\\.git\\/\*"
                "GPATH" "GRTAGS" "GSYMS" "GTAGS"
                "TAGS") dmoccur-exclusion-mask))
