;; Go Lang
(custom-set-variables
 '(ac-go-expand-arguments-into-snippets nil)
 ;;'(company-go-insert-arguments nil)
 '(gofmt-command "goimports"))

(with-eval-after-load 'go-mode
  (add-hook 'go-mode-hook 'my/go-mode-hook)
  (add-hook 'go-mode-hook 'go-eldoc-setup)

  (require 'go-autocomplete)

  (define-key go-mode-map (kbd "C-c a") 'go-import-add)
  (define-key go-mode-map (kbd "C-c C-a") 'helm-godoc-import)
  (define-key go-mode-map (kbd "C-c C-j") 'go-direx-pop-to-buffer)
  (define-key go-mode-map (kbd "C-c C-c") 'my/flycheck-list-errors)
  (define-key go-mode-map (kbd "C-c C-s") 'my/gofmt)
  (define-key go-mode-map (kbd "C-c C-t") 'ff-find-other-file)
  (define-key go-mode-map (kbd "C-c C-d") 'helm-godoc)
  (define-key go-mode-map (kbd "C-c C-l") 'my/flycheck-list-errors)
  (define-key go-mode-map (kbd "C-c ?") 'my/godoc-type-at-cursor)
  (define-key go-mode-map (kbd "M-.") 'godef-jump)
  (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)

  (define-key go-mode-map (kbd ":") nil))

(defvar my/go-impl-interfaces
  '("http.Handler"))

(defun my/go-impl (receiver interface)
  (interactive
   (list
    (read-string "Receiver: ")
    (completing-read "Interface: " my/go-impl-interfaces)))
  (save-excursion
    (unless (process-file "impl" nil t nil receiver interface)
      (error "Error: 'impl' interface=%s" interface))))

(defun my/godoc-type-at-cursor ()
  (interactive)
  (save-excursion
    (unless (looking-at-p "\\>")
      (forward-word 1))
    (let ((cand (go-eldoc--invoke-autocomplete)))
      (when (and cand (string-match "\\`\\([^,]+\\),,\\(.+\\)$" cand))
        (let ((name (match-string-no-properties 1 cand))
              (type (match-string-no-properties 2 cand)))
          (when (string-match "\\`var\\(.+\\)" type)
            (setq type (match-string-no-properties 1 type)))
          (message "%s:%s" (propertize name 'face 'font-lock-type-face) type))))))

(defun my/gofmt ()
  (interactive)
  (when (buffer-modified-p)
    (save-buffer))
  (gofmt)
  (when (buffer-modified-p)
    (save-buffer)))

(defun my/go-mode-hook ()
  ;;(add-to-list 'company-backends 'company-go)
  (delete 'ac-source-words-in-same-mode-buffers ac-sources)
  (setq compile-command "go test")
  (setq flycheck-checker 'go-golint))
