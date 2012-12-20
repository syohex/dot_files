;;;; region setting

;; expand region
(require 'expand-region)
(global-set-key (kbd "M-SPC") 'er/expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region)

;; multimark
(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)

;; wrap-region
(require 'wrap-region)
(wrap-region-global-mode t)

(wrap-region-add-wrapper "*" "*" nil 'org-mode)
(wrap-region-add-wrapper "_" "_" nil 'org-mode)
(wrap-region-add-wrapper "/" "/" nil 'org-mode)
(wrap-region-add-wrapper "+" "+" nil 'org-mode)

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

;; set majar mode derived `prog-mode'
(defvar my/autopair-enable-modes
  '(c-mode c++-mode python-mode ruby-mode))

(defun my/autopair-prog-mode-hook ()
  (when (memq major-mode my/autopair-enable-modes)
    (my/wrap-region-as-autopair)))

(add-hook 'prog-mode-hook 'my/autopair-prog-mode-hook)
