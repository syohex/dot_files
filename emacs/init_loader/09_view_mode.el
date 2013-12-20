;; view-mode
(custom-set-variables
 '(view-read-only t))

(defun View-goto-line-last ()
  (interactive)
  (goto-char (point-max))
  (goto-char (line-beginning-position)))

(eval-after-load "view"
  '(progn
     (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
     (define-key view-mode-map (kbd "?") 'View-search-regexp-backward?)
     (define-key view-mode-map (kbd "g") 'View-goto-line)
     (define-key view-mode-map (kbd "G") 'View-goto-line-last)
     (define-key view-mode-map (kbd "f") 'editutil-forward-char)
     (define-key view-mode-map (kbd "F") 'editutil-backward-char)
     (define-key view-mode-map (kbd "w") 'forward-word)
     (define-key view-mode-map (kbd "b") 'backward-word)

     (define-key view-mode-map (kbd "i") 'editutil-view-insert)
     (define-key view-mode-map (kbd "a") 'editutil-view-insert-at-next)
     (define-key view-mode-map (kbd "I") 'editutil-view-insert-at-bol)
     (define-key view-mode-map (kbd "A") 'editutil-view-insert-at-eol)

     (define-key view-mode-map (kbd "h") 'backward-char)
     (define-key view-mode-map (kbd "j") 'next-line)
     (define-key view-mode-map (kbd "k") 'previous-line)
     (define-key view-mode-map (kbd "l") 'forward-char)
     (define-key view-mode-map (kbd "[") 'backward-paragraph)
     (define-key view-mode-map (kbd "]") 'forward-paragraph)))

(eval-after-load "doc-view"
  '(progn
     (define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
     (define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)))
