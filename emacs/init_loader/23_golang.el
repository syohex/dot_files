;; eldoc
(add-hook 'go-mode-hook 'go-eldoc-setup)

(custom-set-variables
 '(gofmt-command "goimports"))

(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)

     (define-key go-mode-map (kbd "C-c C-j") 'go-direx-pop-to-buffer)
     (define-key go-mode-map (kbd "C-c C-c") 'my/flycheck-list-errors)
     (define-key go-mode-map (kbd "C-c C-s") 'my/gofmt)
     (define-key go-mode-map (kbd "C-c C-t") 'ff-find-other-file)
     (define-key go-mode-map (kbd "C-c C-d") 'helm-godoc)
     (define-key go-mode-map (kbd "C-c ?") 'my/godoc-query)
     (define-key go-mode-map (kbd "M-.") 'godef-jump)
     (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)

     (define-key go-mode-map (kbd ":") nil)))

(defun my/godoc-query ()
  (interactive)
  (godoc (read-string "Query: ")))

(defun my/gofmt ()
  (interactive)
  (when (buffer-modified-p)
    (save-buffer))
  (gofmt)
  (when (buffer-modified-p)
    (save-buffer)))

(defun my/go-mode-hook ()
  (setq compile-command "go test")
  (setq flycheck-checker 'go-golint))
(add-hook 'go-mode-hook 'my/go-mode-hook)
