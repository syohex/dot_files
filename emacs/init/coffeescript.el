;; coffeescript
(custom-set-variables
 '(coffee-tab-width 2)
 '(coffee-indent-like-python-mode t)
 '(coffee-args-compile '("-c" "-m")))

(defun my/coffee-edit-next-line ()
  (interactive)
  (goto-char (line-end-position))
  (coffee-newline-and-indent))

(with-eval-after-load 'coffee-mode
  (add-hook 'coffee-mode-hook 'my/coffee-mode-hook)
  (add-hook 'coffee-after-compile-hook 'sourcemap-goto-corresponding-point)

  (define-key coffee-mode-map [remap newline-and-indent] 'nil)
  (define-key coffee-mode-map (kbd "C-m") 'nil)
  (define-key coffee-mode-map (kbd "C-<return>") 'coffee-newline-and-indent)
  (define-key coffee-mode-map (kbd "M-o") 'my/coffee-edit-next-line)
  (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)

  (smartrep-define-key
      coffee-mode-map "C-c" '(("h" . 'coffee-indent-shift-left)
                              ("l" . 'coffee-indent-shift-right))))

(defun my/coffee-mode-hook ()
  (setq flycheck-checker 'coffee))
