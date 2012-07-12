;;;; recentf-ext
;; (auto-install-from-url-from-emacswiki "recentf-ext.el")
(setq recentf-max-saved-items 2000)

(require 'recentf-ext)
(setq recentf-exclude '("/auto-install/" ".recentf" "/repos/" "/elpa/"
                        "\\.mime-example" "\\.ido.last" "COMMIT_EDITMSG"))
(setq recentf-auto-cleanup 10)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(if window-system
    (run-at-time t 600 'recentf-save-list))

(defadvice recentf-save-list (around no-message activate)
  (flet ((write-file (file &optional confirm)
                     (let ((str (buffer-string)))
                       (with-temp-file file
                                      (insert str)))))
    ad-do-it))

(recentf-mode 1)
