(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)

     (define-key go-mode-map (kbd "C-c C-d") 'my/helm-go)
     (define-key go-mode-map (kbd "M-.") 'godef-jump)))

(defvar my/helm-go-source
  '((name . "Helm Go")
    (candidates . go-packages)
    (action . (("Show document" . godoc)
               ("Import package" . my/helm-go-import-add)))))

(defun my/helm-go-import-add (candidate)
  (dolist (package (helm-marked-candidates))
    (go-import-add current-prefix-arg package)))

(defun my/helm-go ()
  (interactive)
  (helm :sources '(my/helm-go-source) :buffer "*helm go*"))
