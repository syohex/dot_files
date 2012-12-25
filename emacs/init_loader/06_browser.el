;; configuration of emacs-w3m
(add-to-list 'load-path "~/.emacs.d/elisps/emacs-w3m")
(require 'w3m-load)

;; set default browser
(setq browse-url-browser-function 'browse-url-firefox)

;; alc
(defun alc (word)
  (interactive
   (list (read-string "Search Word: " )))
  (browse-url
   (format "http://eow.alc.co.jp/%s/UTF-8/?ref=sa" word)))

;; google search
(defun google (words-str)
  (interactive
   (list
    (read-string "Search Words: ")))
  (let ((query (mapconcat #'identity (split-string words-str) "+")))
    (browse-url
     (format "https://www.google.co.jp/search?&q=%s" query))))
