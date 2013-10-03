;; web-mode
(eval-after-load "web-mode"
  '(progn

     ;; remap key
     (define-key map (kbd "C-c b b") 'web-mode-block-beginning)
     (define-key map (kbd "C-c b e") 'web-mode-block-end)
     (define-key map (kbd "C-c b k") 'web-mode-block-kill)
     (define-key map (kbd "C-c b n") 'web-mode-block-next)
     (define-key map (kbd "C-c b p") 'web-mode-block-previous)
     (define-key map (kbd "C-c b s") 'web-mode-block-select)

     (define-key map (kbd "C-c e b") 'web-mode-element-beginning)
     (define-key map (kbd "C-c e c") 'web-mode-element-clone)
     (define-key map (kbd "C-c e d") 'web-mode-element-child)
     (define-key map (kbd "C-c e e") 'web-mode-element-end)
     (define-key map (kbd "C-c e i") 'web-mode-element-content-select)
     (define-key map (kbd "C-c e k") 'web-mode-element-kill)
     (define-key map (kbd "C-c e n") 'web-mode-element-next)
     (define-key map (kbd "C-c e p") 'web-mode-element-previous)
     (define-key map (kbd "C-c e r") 'web-mode-element-rename)
     (define-key map (kbd "C-c e s") 'web-mode-element-select)
     (define-key map (kbd "C-c e t") 'web-mode-element-traverse)
     (define-key map (kbd "C-c e u") 'web-mode-element-parent)

     (define-key map (kbd "C-c t b") 'web-mode-tag-beginning)
     (define-key map (kbd "C-c t e") 'web-mode-tag-end)
     (define-key map (kbd "C-c t m") 'web-mode-tag-match)
     (define-key map (kbd "C-c t n") 'web-mode-tag-next)
     (define-key map (kbd "C-c t p") 'web-mode-tag-previous)
     (define-key map (kbd "C-c t s") 'web-mode-tag-select)))

;;(add-to-list 'auto-mode-alist '("\\.html?``'" . web-mode))

(defun my/web-mode-hook ()
  (setq web-mode-html-offset   2
        web-mode-css-offset    4
        web-mode-script-offset 2)

  (local-unset-key (kbd "C-c C-b"))
  (local-unset-key (kbd "C-c C-e"))
  (local-unset-key (kbd "C-c C-t")))
(add-hook 'web-mode-hook 'my/web-mode-hook)

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
