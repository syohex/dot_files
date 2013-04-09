;; elscreen
(when window-system
  (require 'elscreen)
  (elscreen-start)
  (global-set-key (kbd "C-z C-z") 'elscreen-toggle)
  (global-set-key (kbd "C-z ,") 'elscreen-screen-nickname)
  (run-with-idle-timer 20 t 'elscreen-frame-title-update)
  (setq elscreen-tab-width nil
        elscreen-tab-display-kill-screen nil)

  ;; Don't show tab number in mode-line
  (setq-default elscreen-e21-mode-line-string nil)
  (remove-hook 'elscreen-screen-update-hook 'elscreen-e21-mode-line-update)
  (add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update)
  (require 'helm-elscreen)
  (global-set-key (kbd "C-z C-l") 'helm-elscreen)
  (elscreen-toggle-display-tab))

;; update frame title to window names
(defun elscreen-frame-title-update ()
  (interactive)
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let ((sort-func #'(lambda (a b) (< (car a) (car b)))))
      (loop with screen-list = (copy-list (elscreen-get-screen-to-name-alist))
            for (index . name) in (sort screen-list sort-func)
            for status = (elscreen-status-label index)
            for name = (my/elscreen-filter-name name)
            collect (format "%d%s %s" index status name) into screen-names
            finally
            (set-frame-name (mapconcat #'identity screen-names " "))))))

(defun my/elscreen-filter-name (screen-name)
  (let ((case-fold-search nil))
    (cond ((string-match "^WL" screen-name) "Wl(draft)")
          ((string-match "Minibuf" screen-name)
           (replace-regexp-in-string "\\*Minibuf-\\w\\*" "" screen-name))
          (t screen-name))))

;; for `cde' command. move to directorycurrent buffer
(defun elscreen-get-current-directory (buf)
  (with-current-buffer buf
    (aif (buffer-file-name)
        (file-name-directory it)
      default-directory)))

(defun elscreen-current-directory ()
  (let* ((screen-history  (elscreen-get-conf-list 'screen-history))
         (screen-property (elscreen-get-conf-list 'screen-property))
         (current-screen (car screen-history))
         (property (cadr (assoc current-screen screen-property)))
         (curbuf (marker-buffer (nth 2 property))))
    (elscreen-get-current-directory curbuf)))

(defun non-elscreen-current-directory ()
  (let* ((bufsinfo (cadr (cadr (current-frame-configuration))))
         (bufname-list (assoc-default 'buffer-list bufsinfo)))
    (loop for buf in bufname-list
          for file = (or (buffer-file-name buf)
                         (with-current-buffer buf
                           (when (eq major-mode 'dired-mode)
                             dired-directory)))
          when (buffer-file-name buf)
          return (file-name-directory it))))
