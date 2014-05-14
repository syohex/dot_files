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
     (define-key go-mode-map (kbd "C-c C-t") 'my/go-toggle-test-file)
     (define-key go-mode-map (kbd "C-c C-d") 'helm-godoc)
     (define-key go-mode-map (kbd "C-c [") 'my/go-insert-bracket)
     (define-key go-mode-map (kbd "C-c ?") 'my/godoc-query)
     (define-key go-mode-map (kbd "M-.") 'godef-jump)
     (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)

     (define-key go-mode-map (kbd ":") nil)))

(defun my/godoc-query ()
  (interactive)
  (godoc (read-string "Query: ")))

(defun my/go-insert-bracket ()
  (interactive)
  (insert "[]"))

(defun my/gofmt ()
  (interactive)
  (when (buffer-modified-p)
    (save-buffer))
  (gofmt)
  (save-buffer))

(defun my/go-mode-hook ()
  (setq flycheck-checker 'go-golint))
(add-hook 'go-mode-hook 'my/go-mode-hook)

(defun my/go-toggle-test-file ()
  (interactive)
  (let ((file (buffer-file-name)))
    (unless file
      (error "Error: this buffer is not related to real file"))
    (let* ((basename (file-name-nondirectory file))
           (switched-file (if (string-match "_test" file)
                              (replace-regexp-in-string "_test" "" basename)
                            (replace-regexp-in-string "\\.go\\'" "_test.go" basename)))
           (find-func (if current-prefix-arg 'find-file-other-window 'find-file)))
      (funcall find-func switched-file))))
