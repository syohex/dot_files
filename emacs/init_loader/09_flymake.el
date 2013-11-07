;; setting for flymake

;; avoid abnormal exit
(eval-after-load "flymake"
  '(defadvice flymake-post-syntax-check (before
                                         flymake-force-check-was-interrupted
                                         activate)
     (setq flymake-check-was-interrupted t)))

(defsubst my/flycheck-enable-mode-p (mode)
  (or (memq mode my/flycheck-enable-modes) (memq mode '(go-mode))))

(defsubst my/flycheck-reset-function ()
  (setq flycheck-display-errors-function 'flycheck-display-error-messages))

(defun my/flycheck-list-errors ()
  (interactive)
  (setq flycheck-display-errors-function nil)
  (if (not (my/flycheck-enable-mode-p major-mode))
      (error "This mode can't use flycheck-mode")
    (unless flycheck-mode
      (flycheck-mode +1))
    (call-interactively 'flycheck-list-errors)))

(defun my/toggle-flymake ()
  (interactive)
  (if (not (my/flycheck-enable-mode-p major-mode))
      (call-interactively 'flymake-mode)
    (call-interactively 'flycheck-mode)
    (my/flycheck-reset-function)))

(defun my/flymake-popup-error-message ()
  (interactive)
  (if (and (boundp 'flycheck-mode) flycheck-mode)
      (my/flycheck-reset-function)
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
       (decf count)))))

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
                         :foreground nil :background nil)
     (set-face-attribute 'flycheck-error-list-highlight-at-point nil
                         :background "grey15")))

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
