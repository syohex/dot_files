;; elscreen
(elscreen-start)
(global-set-key (kbd "C-z C-z") 'elscreen-toggle)
(global-set-key (kbd "C-z ,") 'elscreen-screen-nickname)
(global-set-key (kbd "C-z C") 'elscreen-editutil-clone-only-this-window)
(global-set-key (kbd "C-z C-l") 'helm-editutil-elscreen)
(run-with-idle-timer 20 t 'elscreen-editutil-update-frame-title)

(custom-set-variables
 '(elscreen-display-screen-number nil)
 '(elscreen-tab-display-kill-screen nil)

 '(elscreen-mode-to-nickname-alist
   '(("^dired-mode$" . (lambda () (format "Dired(%s/)" (buffer-name))))
     ("^Info-mode$" . (lambda ()
                        (format "Info(%s)" (file-name-nondirectory Info-current-file))))))

 '(elscreen-buffer-to-nickname-alist
   '(("Minibuf". ""))))

;; Don't show tab number in mode-line
(setq-default elscreen-mode-line-string nil)
(remove-hook 'elscreen-screen-update-hook 'elscreen-mode-line-update)
(add-hook 'elscreen-screen-update-hook 'elscreen-editutil-update-frame-title)
(elscreen-toggle-display-tab)
