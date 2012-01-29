;; default frame
(when window-system
  (if (system-macosx-p)
      (setq default-frame-alist
	    '((width . 95) (height . 70) (top . 0) (left . 0)))
    (setq default-frame-alist
	    '((width . 115) (height . 42) (top . 28) (left . 0)))))
