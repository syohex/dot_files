(setq ansi-color-names-vector
      ["gray" "orange" "green" "gold" "DeepSkyBlue" "magenta" "cyan" "white"])

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(autoload 'shell-pop "shell-pop" nil t)
(setq shell-file-name "/bin/bash")
(eval-after-load "shell-pop"
    '(progn
       (shell-pop-set-universal-key (kbd "M-g M-s"))
       (shell-pop-set-internal-mode "shell")
       (shell-pop-set-internal-mode-shell "/bin/bash")
       (shell-pop-set-window-height 30)
       (shell-pop-set-window-position "bottom")
       (shell-pop-set-default-directory (expand-file-name "~/"))))
