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

;; anything-c-moccur
(require 'anything-c-moccur)
(define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)

(setq anything-c-moccur-anything-idle-delay 0.2
      anything-c-moccur-higligt-info-line-flag t
      anything-c-moccur-enable-auto-look-flag t
      anything-c-moccur-enable-initial-pattern t)
