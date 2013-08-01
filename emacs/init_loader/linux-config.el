;; font-setting for Linux(Ubuntu)

(defun change-font-size (size)
  (interactive
   (list (read-number "Size: ")))
  (set-frame-font (format "VL ゴシック-%d" size)))

(when window-system
  (with-temp-buffer
    (call-process "xdpyinfo" nil t)
    (goto-char (point-min))
    (when (re-search-forward "dimensions:\\s-+\\([0-9]+\\)x\\([0-9]+\\)" nil t)
      (let* ((width (string-to-number (match-string-no-properties 1)))
             (size (if (>= width 1900) 12 10)))
        (condition-case err
            (set-frame-font (format "VL ゴシック-%d" size))
          (error (message "%s" err)))))))