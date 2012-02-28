;; setting for javascript
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

(setq-default js-auto-indent-flag nil)

;; setting for flymake(PLEASE INSTALL jslint)
(add-to-list 'flymake-allowed-file-name-masks '("\\.js\\'" flymake-js-init))
(defun flymake-js-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "jslint" (list "--no-es5" local-file))))
(defun flymake-js-load ()
  (interactive)
  (add-to-list 'flymake-err-line-patterns
               '("^ *[[:digit:]] \\([[:digit:]]+\\),\\([[:digit:]]+\\)\: \\(.+\\)$"
                 nil 1 2 3))
  (flymake-mode t))

(add-hook 'js-mode-hook
          (lambda ()
            (flymake-js-load)))
