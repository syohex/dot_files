;; SDIC dictonary for Linux
(global-set-key (kbd "C-c w") 'my/sdic-describe-word)

(defun my/sdic-describe-word (word)
  (interactive
   (list (or (thing-at-point 'word)
             (read-string "Word: "))))
  (with-current-buffer (get-buffer-create "*sdic*")
    (read-only-mode -1)
    (erase-buffer)
    (unless (call-process "dict" nil t nil word)
      (error "Failed: 'dict %s'" word))
    (goto-char (point-min))
    (ansi-color-apply-on-region (point-min) (point-max))
    (view-mode +1)
    (read-only-mode +1)
    (pop-to-buffer (current-buffer))))
