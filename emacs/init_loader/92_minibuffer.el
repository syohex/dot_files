;; setting for minibuffer
(defun my/minibuffer-delete-parent-directory ()
  "Delete one level of file path."
  (interactive)
  (let ((current-pt (point)))
    (cond ((or (re-search-backward "/[^/]+/?" nil t)
               (re-search-backward "[^-]-" nil t))
           (forward-char 1)
           (delete-region (point) current-pt))
          (t
           (back-to-indentation)
           (delete-region (point) current-pt)))))

(define-key minibuffer-local-map  (kbd "M-<backspace>")
  'my/minibuffer-delete-parent-directory)
