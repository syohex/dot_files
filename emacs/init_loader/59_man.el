;; man-path
(setq woman-use-own-frame nil)
(setq woman-cache-filename (expand-file-name "~/.emacs.d/woman_cache.el"))
(setq woman-manpath '("/usr/share/man"
                      "/usr/local/man"
                      "/usr/man"
                      ))

; spliting window when opening woman buffer
(defadvice woman-really-find-file (around woman-split-window activate)
  (switch-to-buffer-other-window (get-buffer-create "*woman-dummy*"))
  ad-do-it)

(defun my/anything-man ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-man-pages
     anything-c-source-info-pages)
   " *anything-man*"))

(global-set-key (kbd "M-<f1>") 'my/anything-man)
