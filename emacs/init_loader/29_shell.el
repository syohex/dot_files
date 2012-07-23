;; not display password in shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

(defun eshell-other-window ()
  "Run eshell on other window"
  (interactive)
  (let ((eshell-buffer-name "*eshell pop*"))
    (switch-to-buffer-other-window
     (get-buffer-create "*eshell pop*"))
    (eshell)))

(require 'em-alias)
(add-to-list 'eshell-command-aliases-list
             '("cdp" "cd {git rev-parse --show-toplevel}"))

(global-set-key (kbd "M-g M-s") 'eshell-other-window)
