;; default frame
(when (and window-system (not (macosx-p)))
  (setq default-frame-alist
        '((width . 115) (height . 42) (top . 28) (left . 0))))
