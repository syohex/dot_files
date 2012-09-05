;; default frame
(when (and window-system (not (macosx-p)))
  (setq default-frame-alist
        '((width . 115) (height . 42) (top . 28) (left . 0))))

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil
                       'fullscreen
                       (cond ((frame-parameter nil 'fullscreen) nil)
                             (t 'fullboth))))

(global-set-key (kbd "C-x C-z") 'toggle-fullscreen)
