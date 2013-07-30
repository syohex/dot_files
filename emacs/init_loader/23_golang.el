(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)
     (add-hook 'go-mode-hook 'go-eldoc-setup)

     (define-key go-mode-map (kbd "C-c C-c") 'quickrun-compile-only)
     (define-key go-mode-map (kbd "C-c C-s") 'my/go-cleanup)
     (define-key go-mode-map (kbd "M-g M-t") 'my/go-test)
     (define-key go-mode-map (kbd "C-c C-t") 'my/go-toggle-test-file)
     (define-key go-mode-map (kbd "C-c C-d") 'my/helm-go)
     (define-key go-mode-map (kbd "M-.") 'godef-jump)
     (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)))

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

(defun my/go-cleanup ()
  (interactive)
  (save-buffer)
  (go-remove-unused-imports nil)
  (gofmt)
  (call-interactively 'go-errcheck)
  (save-buffer))

(defun my/go-test ()
  (interactive)
  (let ((package (save-excursion
                   (goto-char (point-min))
                   (let ((regexp (concat "package\\s-+\\(" go-identifier-regexp "\\)")))
                     (if (re-search-forward regexp nil t)
                         (match-string-no-properties 1)
                       (error "Error: Can't find package name"))))))
    (let ((compilation-scroll-output t)
          (cmd (concat "go test " package)))
      (compile cmd))))
