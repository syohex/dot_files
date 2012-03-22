;; view-mode
(setq view-read-only t)

(defun View-goto-line-last (&optional line)
  "goto last line"
  (interactive "P")
  (goto-line (line-number-at-pos (point-max))))

(require 'view)
;; less like
(define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
(define-key view-mode-map (kbd "?") 'View-search-regexp-backward?)
(define-key view-mode-map (kbd "g") 'View-goto-line)
(define-key view-mode-map (kbd "G") 'View-goto-line-last)
(define-key view-mode-map (kbd "b") 'View-scroll-page-backward)
(define-key view-mode-map (kbd "f") 'View-scroll-page-forward)
;; vi/w3m like
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "j") 'next-line)
(define-key view-mode-map (kbd "k") 'previous-line)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "[") 'backward-paragraph)
(define-key view-mode-map (kbd "]") 'forward-paragraph)
(define-key view-mode-map (kbd "J") 'View-scroll-line-forward)
(define-key view-mode-map (kbd "K") 'View-scroll-line-backward)

;; insert-mode
(defun my/view-insert ()
  (interactive)
  (toggle-read-only))
(define-key view-mode-map (kbd "i") 'my/view-insert)

(defun my/view-insert-bol ()
  (interactive)
  (back-to-indentation)
  (toggle-read-only))
(define-key view-mode-map (kbd "I") 'my/view-insert-bol)

(defun my/view-insert-after ()
  (interactive)
  (unless (eolp)
      (forward-char))
  (toggle-read-only))
(define-key view-mode-map (kbd "a") 'my/view-insert-after)

(defun my/view-insert-eol ()
  (interactive)
  (end-of-line)
  (toggle-read-only))
(define-key view-mode-map (kbd "A") 'my/view-insert-eol)

(defun my/view-insert-next-line ()
  (interactive)
  (toggle-read-only)
  (end-of-line)
  (newline-and-indent))
(define-key view-mode-map (kbd "o") 'my/view-insert-next-line)

(defun my/view-insert-prev-line ()
  (interactive)
  (forward-line -1)
  (toggle-read-only)
  (if (not (= (current-line) 1))
      (end-of-line))
  (newline-and-indent))
(define-key view-mode-map (kbd "O") 'my/view-insert-prev-line)

;; Changeing mode-line color when view-mode is enable
(require 'viewer)
(viewer-stay-in-setup)
(setq viewer-modeline-color-unwritable "#9400d3"
      viewer-modeline-color-view       "light green")
(viewer-change-modeline-color-setup)

;; top priority view-mode
(add-hook 'view-mode-hook
          (lambda ()
            (let ((vm (assq 'view-mode minor-mode-map-alist)))
              (setq minor-mode-map-alist
                    (cons vm (delete vm minor-mode-map-alist))))))
