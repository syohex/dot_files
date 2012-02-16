;;;; minor key setting
(define-key hs-minor-mode-map (kbd "C-#") 'hs-toggle-hiding)

;; (makunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  "Most superior minir mode"
  t  ;; default is enable
  "" ;; Not display mode-line
  `((,(kbd "C-j") . dabbrev-expand)))
