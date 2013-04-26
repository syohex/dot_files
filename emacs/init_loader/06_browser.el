;; configuration of emacs-w3m
(add-to-list 'load-path (concat user-emacs-directory "elisps/emacs-w3m"))
(autoload 'w3m "w3m-load" nil t)

;; set default browser
(unless (macosx-p)
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "/opt/google/chrome/google-chrome"))
