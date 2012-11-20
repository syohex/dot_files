;;;; region setting

;; multimark
(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)

;; wrap-region
(require 'wrap-region)
(wrap-region-global-mode t)

(defun my/wrap-region-zero-width ()
  (let ((region-size (- (region-end) (region-beginning)))
        (wrapper (wrap-region-find (char-to-string last-input-event))))
    (when (and (zerop region-size) wrapper)
      (let ((left (wrap-region-wrapper-left wrapper)))
        (forward-char (length left))))))

(add-hook 'wrap-region-after-wrap-hook 'my/wrap-region-zero-width)

;; disable paredit enable mode
(add-to-list 'wrap-region-except-modes 'emacs-lisp-mode)
(add-to-list 'wrap-region-except-modes 'scheme-mode)
(add-to-list 'wrap-region-except-modes 'lisp-mode)
(add-to-list 'wrap-region-except-modes 'clojure-mode)

;; my own autoinsert implementation with wrap-region
(defun my/wrap-region-trigger (input)
  `(lambda ()
     (interactive)
     (unless (use-region-p)
       (set-mark (point)))
     (let ((last-input-event ,(string-to-char input)))
       (wrap-region-trigger 1 ,input))))

(defun my/wrap-region-as-autopair ()
  (local-set-key (kbd "M-\"") (my/wrap-region-trigger "\""))
  (local-set-key (kbd "M-'")  (my/wrap-region-trigger "'"))
  (local-set-key (kbd "M-(")  (my/wrap-region-trigger "("))
  (local-set-key (kbd "M-[")  (my/wrap-region-trigger "["))
  (local-set-key (kbd "M-{")  (my/wrap-region-trigger "{")))

(defvar my/autopair-enable-modes
  '(c-mode c++-mode cperl-mode python-mode
           haskell-mode inferior-haskell-mode))

(defun my/autopair-prog-mode-hook ()
  (when (memq major-mode my/autopair-enable-modes)
    (my/wrap-region-as-autopair)))

(add-hook 'prog-mode-hook 'my/autopair-prog-mode-hook)
