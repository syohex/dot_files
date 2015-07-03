;; company-mode
(custom-set-variables
 '(company-idle-delay nil))

(global-company-mode +1)
;; suppress minibuffer message
(fset 'company-echo-show 'ignore)

(global-set-key (kbd "C-M-i") 'company-complete)

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

(define-key lisp-interaction-mode-map (kbd "C-M-i") 'company-elisp)
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
