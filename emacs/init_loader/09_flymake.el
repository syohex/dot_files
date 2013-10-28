;; setting for flymake
(require 'flymake)
;; avoid abnormal exit
(defadvice flymake-post-syntax-check (before
                                      flymake-force-check-was-interrupted
                                      activate)
  (setq flymake-check-was-interrupted t))

(defun my/toggle-flymake ()
  (interactive)
  (if (or (memq major-mode my/flycheck-enable-modes)
          (memq major-mode '(go-mode)))
      (call-interactively 'flycheck-mode)
    (call-interactively 'flymake-mode)))

(defun my/flymake-popup-error-message ()
  (interactive)
  (let* ((line-no (flymake-current-line-no))
         (cur-err-info (flymake-find-err-info flymake-err-info line-no))
         (line-err-info-list (nth 0 cur-err-info))
         (count (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((err-info (nth (1- count) line-err-info-list))
               (file (flymake-ler-file err-info))
               (full-file (flymake-ler-full-file err-info))
               (text (flymake-ler-text err-info))
               (line (flymake-ler-line err-info)))
          (popup-tip (format "[%s] %s" line text))))
      (decf count))))

;; flycheck
;; enable flycheck
(defvar my/flycheck-enable-modes
  '(coffee-mode
    python-mode
    js-mode
    ruby-mode))

(dolist (mode my/flycheck-enable-modes)
  (add-hook (intern (format "%s-hook" mode)) 'flycheck-mode))

(custom-set-variables
 '(flycheck-display-errors-delay 0.2))

;; flycheck faces
(eval-after-load "flycheck"
  '(progn
     (set-face-attribute 'flycheck-error nil
                         :foreground "yellow" :weight 'bold
                         :background "red")
     (set-face-attribute 'flycheck-warning nil
                         :weight 'bold :underline "darkorange"
                         :foreground nil :background nil)))

(defun my/flymake-goto-next-error (arg)
  (interactive "P")
  (if (and (boundp 'flycheck-mode) flycheck-mode)
      (flycheck-next-error arg)
    (flymake-goto-next-error)
    (my/flymake-popup-error-message)))

(defun my/flymake-goto-previous-error (arg)
  (interactive "P")
  (if (and (boundp 'flycheck-mode) flycheck-mode)
      (flycheck-previous-error arg)
    (flymake-goto-prev-error)
    (my/flymake-popup-error-message)))

(global-set-key (kbd "M-g M-n") 'my/flymake-goto-next-error)
(global-set-key (kbd "M-g M-p") 'my/flymake-goto-previous-error)
