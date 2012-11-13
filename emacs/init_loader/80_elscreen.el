;; elscreen
(when window-system
  (require 'elscreen)
  (elscreen-start)
  (global-set-key (kbd "C-z ,") 'elscreen-screen-nickname)
  (run-with-idle-timer 5 t 'elscreen-frame-title-update)
  (global-set-key (kbd "C-z u") 'elscreen-frame-title-update)
  (setq elscreen-tab-width nil)
  (setq elscreen-tab-display-kill-screen nil)
  (add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update)
  (require 'helm-elscreen)
  (global-set-key (kbd "C-z C-z") 'helm-elscreen)
  (elscreen-toggle-display-tab))

;; update frame title to window names
(defun elscreen-frame-title-update ()
  (interactive)
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
           (screen-to-name-alist (elscreen-get-screen-to-name-alist))
           (title (mapconcat
                   (lambda (screen)
                     (format "%d%s %s"
                             screen (elscreen-status-label screen)
                             (my/get-screen-name (get-alist screen screen-to-name-alist))))
                   screen-list " ")))
      (set-frame-name title))))

(defun my/get-screen-name (screen-name)
  (let ((case-fold-search nil))
    (cond ((string-match "^WL" screen-name) "Wl(draft)")
          ((string-match "Minibuf" screen-name)
           (replace-regexp-in-string "\\*Minibuf-\\w\\*" "" screen-name))
          (t screen-name))))

;; for `cde' command. move to directorycurrent buffer
(defun elscreen-get-current-directory (buf)
  (with-current-buffer buf
    (let ((bufname (buffer-file-name)))
      (if bufname
          (file-name-directory bufname)
        (expand-file-name (cadr (split-string (pwd))))))))

(defun elscreen-current-directory ()
  (let* ((screen-history  (elscreen-get-conf-list 'screen-history))
         (screen-property (elscreen-get-conf-list 'screen-property))
         (current-screen (car screen-history))
         (property (cadr (assoc current-screen screen-property)))
         (curbuf (marker-buffer (nth 2 property))))
    (elscreen-get-current-directory curbuf)))

(defun non-elscreen-current-directory ()
  (let* ((frame-info (cadr (cadr (current-frame-configuration))))
         (buflist (cadr (assoc 'buffer-list frame-info)))
         (curbuf (nth 1 buflist)))
    (elscreen-get-current-directory curbuf)))
