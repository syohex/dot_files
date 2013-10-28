(require 'flymake)

;; setting for flymake
(defun my/toggle-flymake ()
  (interactive)
  (if (or (memq major-mode my/flycheck-enable-modes)
          (memq major-mode '(go-mode)))
      (call-interactively 'flycheck-mode)
    (call-interactively 'flymake-mode)))

;; avoid abnormal exit
(eval-after-load "flymake"
  '(progn
     (defadvice flymake-post-syntax-check (before
                                           flymake-force-check-was-interrupted
                                           activate)
       (setq flymake-check-was-interrupted t))))

(eval-after-load "popup"
  '(progn
     (when (eq 'unspecified (face-attribute 'popup-tip-face :height))
       (set-face-attribute 'popup-tip-face nil :height 1.0))
     (when (eq 'unspecified (face-attribute 'popup-tip-face :weight))
       (set-face-attribute 'popup-tip-face nil :weight 'normal))))

;; flycheck
;; enable flycheck
(defvar my/flycheck-enable-modes
  '(coffee-mode
    python-mode
    js-mode
    ruby-mode))

(dolist (mode my/flycheck-enable-modes)
  (add-hook (intern (format "%s-hook" mode)) 'flycheck-mode))

;; flycheck faces
(eval-after-load "flycheck"
  '(progn
     (setq flycheck-display-errors-delay 0.2)

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
    (flymake-goto-next-error)))

(defun my/flymake-goto-previous-error (arg)
  (interactive "P")
  (if (and (boundp 'flycheck-mode) flycheck-mode)
      (flycheck-previous-error arg)
    (flymake-goto-prev-error)))

(global-set-key (kbd "M-g M-n") 'my/flymake-goto-next-error)
(global-set-key (kbd "M-g M-p") 'my/flymake-goto-previous-error)
