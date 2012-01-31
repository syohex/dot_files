;; twittering-mode
(add-hook 'load-path "~/.emacs.d/repos/twittering-mode")
(when (require 'twittering-mode nil t)
  (setq twittering-icon-mode t)
  (setq twittering-status-format "%i %s,  %@:\n%FILL[  ]{%T // from %f%L%r%R}\n")
  (setq twittering-update-status-function 'twittering-update-status-from-pop-up-buffer)
  (define-key twittering-edit-mode-map (kbd "C-c u") 'my/twittering-url-title)
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
  (twittering-enable-unread-status-notifier))

(defun my/twittering-url-title (url)
  (interactive "sURL: ")
  (save-excursion
    (call-process "url_title.pl" nil t t url)))
