;; html-mode
(defun html-mode-insert-br ()
  (interactive)
  (insert "<br />"))

(eval-after-load "sgml-mode"
  '(progn
     (define-key html-mode-map (kbd "C-c b") 'html-mode-insert-br)))

;; emmet-coding
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)

;; auto-complete for CSS
(defvar ac-source-css-property-names
  '((candidates . (loop for property in ac-css-property-alist
                        collect (car property)))))

(defun my-css-mode-hook ()
  (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-css-property-names))
(add-hook 'css-mode-hook 'my-css-mode-hook)
