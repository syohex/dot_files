;; elscreen
(if window-system
    (progn
      (elscreen-start)
      (global-set-key (kbd "C-z ,") 'elscreen-screen-nickname)
      (setq elscreen-tab-width nil)
      (setq elscreen-tab-display-kill-screen nil)
      (elscreen-toggle-display-tab)))

;; ウインドウのタイトルにタグ名を反映
(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
           (screen-to-name-alist (elscreen-get-screen-to-name-alist))
           (title (mapconcat
                   (lambda (screen)
                     (format "%d%s %s"
                             screen (elscreen-status-label screen)
                             (my/get-screen-name (get-alist screen screen-to-name-alist))))
                   screen-list " ")))
      (if (fboundp 'set-frame-name)
          (set-frame-name title)
        (setq frame-title-format title)))))

(defun my/get-screen-name (screen-name)
  (let ((case-fold-search nil))
    (cond ((string-match "^WL" screen-name) "Wl(draft)")
          ((string-match "Minibuf" screen-name)
           (replace-regexp-in-string "\\*Minibuf-\\w\\*" "" screen-name))
          (t screen-name))))

(if window-system
    (eval-after-load "elscreen"
      '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update)))

(defun elscreen-current-directory ()
  (let* (current-dir
        (active-file-name
         (with-current-buffer
             (let* ((current-screen (car (elscreen-get-conf-list 'screen-history)))
                    (property (cadr (assoc current-screen
                                           (elscreen-get-conf-list 'screen-property)))))
               (marker-buffer (nth 2 property)))
           (progn
             (setq current-dir (expand-file-name (cadr (split-string (pwd)))))
             (buffer-file-name)))))
    (if active-file-name
        (file-name-directory active-file-name)
      current-dir)))

(defun non-elscreen-current-directory ()
  (let* (current-dir
         (current-buffer
          (nth 1 (assoc 'buffer-list
                        (nth 1 (nth 1 (current-frame-configuration))))))
         (active-file-name
          (with-current-buffer current-buffer
            (progn
              (setq current-dir (expand-file-name (cadr (split-string (pwd)))))
              (buffer-file-name)))))
    (if active-file-name
        (file-name-directory active-file-name)
      current-dir)))

;; open draft in new tab
(when window-system
  (require 'elscreen-wl nil t)
  (require 'elscreen-server nil t))

(eval-after-load "elscreen-server"
  '(defadvice server-edit (after server-edit-after activate)
     (elscreen-kill)))
