;;;; minor key setting

;; (makunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  "Most superior minir mode"
  t  ;; default is enable
  "" ;; Not display mode-line
  `((,(kbd "M-a") . backward-paragraph)
    (,(kbd "M-e") . forward-paragraph)
    (,(kbd "C-M-j") . dabbrev-expand)
    (,(kbd "C-M-i") . my/auto-complete)
    (,(kbd "M-q") . ace-jump-word-mode)
    (,(kbd "M-C-o") . other-window)))
