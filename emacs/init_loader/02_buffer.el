;;;; setting about `buffer'

;; auto-save
(defun my/auto-save-buffers ()
  (save-excursion
    (dolist (buffer (buffer-list))
      (set-buffer buffer)
      (when (and (buffer-file-name)
                 (buffer-modified-p)
                 (not buffer-read-only)
                 (file-writable-p (buffer-file-name)))
        (save-buffer)))))

(run-with-idle-timer 10 t 'my/auto-save-buffers)

;; naming of same name file
(require 'uniquify)
(custom-set-variables
 '(uniquify-buffer-name-style 'post-forward-angle-brackets))

;; use ibuffer instead of list-buffer
(defalias 'list-buffers 'ibuffer)

(global-set-key (kbd "M-9") 'bs-cycle-next)
(global-set-key (kbd "M-0") 'bs-cycle-previous)
