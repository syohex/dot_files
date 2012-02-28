;;;; minor key setting
(eval-after-load 'hs-minor-mode
  '(progn
     (define-key hs-minor-mode-map (kbd "C-#") 'hs-toggle-hiding)))

;; (makunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  "Most superior minir mode"
  t  ;; default is enable
  "" ;; Not display mode-line
  `((,(kbd "C-j") . dabbrev-expand)
    (,(kbd "M-j") . jaunte)
    (,(kbd "M-q") . quickrun)
    (,(kbd "C-c C-f") . anything-project)
    (,(kbd "M-e") . flymake-goto-next-error)
    (,(kbd "M-E") . flymake-goto-prev-error)))
