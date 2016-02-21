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
  (define-key go-mode-map (kbd "C-c C-t") 'ff-find-other-file)
  (define-key go-mode-map (kbd "C-c C-d") 'helm-godoc)
  (define-key go-mode-map (kbd "C-c d") 'godoc-at-point)
  (define-key go-mode-map (kbd "C-c C-l") 'my/flycheck-list-errors)
  (define-key go-mode-map (kbd "M-.") 'godef-jump)
  (define-key go-mode-map (kbd "M-,") 'pop-tag-mark)

  (define-key go-mode-map (kbd ":") nil)

  (progutil-go-setup))

(defun my/go-mode-hook ()
  ;;(add-to-list 'company-backends 'company-go)
  (delete 'ac-source-words-in-same-mode-buffers ac-sources)
  (setq compile-command "go test")
  (setq flycheck-checker 'go-golint))
