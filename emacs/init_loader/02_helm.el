;;;; helm
(custom-set-variables
 '(helm-input-idle-delay 0)
 '(helm-exit-idle-delay 0)
 '(helm-candidate-number-limit 500)
 '(helm-ag-insert-at-point 'symbol)
 '(helm-swoop-pre-input-function 'ignore)
 '(helm-find-files-doc-header "")
 '(helm-command-prefix-key nil))

(with-eval-after-load 'helm
  (helm-descbinds-mode)

  (define-key helm-map (kbd "C-p")   'helm-previous-line)
  (define-key helm-map (kbd "C-n")   'helm-next-line)
  (define-key helm-map (kbd "C-M-n") 'helm-next-source)
  (define-key helm-map (kbd "C-M-p") 'helm-previous-source)
  (define-key helm-map (kbd "C-e") 'helm-editutil-select-2nd-action)
  (define-key helm-map (kbd "C-j") 'helm-editutil-select-3rd-action))

;; helm faces
(with-eval-after-load 'helm-files
  (define-key helm-find-files-map (kbd "C-M-u") 'helm-find-files-down-one-level))
