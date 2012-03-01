;; css-mode
(autoload 'css-mode "css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))

;; for auto-complete
(defvar ac-source-css-property-names
  '((candidates . (loop for property in ac-css-property-alist
                        collect (car property)))))

(defun my-css-mode-hook ()
  (add-to-list 'ac-sources 'ac-source-css-property)
  (add-to-list 'ac-sources 'ac-source-css-property-names))
(add-hook 'css-mode-hook 'my-css-mode-hook)

;;;; sass-mode
;; (auto-install-from-url "https://raw.github.com/nex3/sass-mode/master/sass-mode.el")
(autoload 'sass-mode "sass-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
