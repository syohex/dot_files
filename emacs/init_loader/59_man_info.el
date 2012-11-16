;;;; Man and Info document setting

;; woman setting
(setq woman-use-own-frame nil)
(setq woman-cache-filename (expand-file-name "~/.emacs.d/woman_cache.el"))
(setq woman-manpath '("/usr/share/man" "/usr/local/man" "/usr/man"))

; spliting window when opening woman buffer
(defadvice woman-really-find-file (around woman-split-window activate)
  (switch-to-buffer-other-window (get-buffer-create "*woman-dummy*"))
  ad-do-it)

;;; info
(defun my/info-mode-hook ()
  (local-set-key "j" 'next-line)
  (local-set-key "k" 'previous-line)
  (local-set-key " " 'Info-scroll-up)
  (local-set-key "b" 'Info-scroll-down)
  (local-set-key "g" 'beginning-of-buffer)
  (local-set-key "G" 'end-of-buffer)

  (local-set-key "J" (lambda () (interactive) (scroll-up 1)))
  (local-set-key "K" (lambda () (interactive) (scroll-down 1)))

  (local-set-key "l" 'forward-word)
  (local-set-key "h" 'backward-word)

  (local-set-key "B" 'Info-history-back)
  (local-set-key "F" 'Info-history-forward)

  (local-set-key "o" 'Info-follow-nearest-node)

  (local-set-key "n" 'Info-next-reference)
  (local-set-key "p" 'Info-prev-reference))

(add-hook 'Info-mode-hook 'my/info-mode-hook)
