;;;; minor key setting
(autoload 'hs-minor-mode "hideshow" nil t)
(eval-after-load "hideshow"
  '(progn
     (define-key hs-minor-mode-map (kbd "C-#") 'hs-toggle-hiding)))

;; (makunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  "Most superior minir mode"
  t  ;; default is enable
  "" ;; Not display mode-line
  `((,(kbd "C-M-j") . dabbrev-expand)
    (,(kbd "M-C-o") . other-window)
    (,(kbd "M-q") . toggle-read-only)))
