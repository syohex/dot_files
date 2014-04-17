;;;; minor key setting

;; (makunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  "Most superior minir mode"
  t  ;; default is enable
  "" ;; Not display mode-line
  `((,(kbd "C-M-j") . dabbrev-expand)
    (,(kbd "C-M-i") . my/auto-complete)
    (,(kbd "M-e") . editutil-forward-char)
    (,(kbd "M-a") . editutil-backward-char)
    (,(kbd "M-q") . editutil-zap-to-char)
    (,(kbd "M-Q") . editutil-zap-to-char-backward)
    (,(kbd "C-M-o") . editutil-other-window)))
