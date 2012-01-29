;;;; setting for searching

;; setting migemo
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
(setq migemo-isearch-enable-p nil)

(defadvice isearch-done (after migemo-search-ad activate)
  "Disable migemo"
  (if migemo-isearch-enable-p
      (setq migemo-isearch-enable-p nil)))
