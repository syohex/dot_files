;; font-setting for Linux(Ubuntu)

(when (and window-system (not (macosx-p)))
  (with-temp-buffer
    (shell-command "xdpyinfo" t)
    (goto-char (point-min))
    (when (re-search-forward "dimensions:\s+\\([0-9]+\\)x\\([0-9]+\\)" nil t)
      (let ((width (string-to-int (buffer-substring-no-properties
                                   (match-beginning 1) (match-end 1))))
            (height (string-to-int (buffer-substring-no-properties
                                    (match-beginning 2) (match-end 2)))))
        (cond
         ((>= width 1900) (set-default-font "VL ゴシック-12"))
         (t (set-default-font "VL ゴシック-10")))))))
