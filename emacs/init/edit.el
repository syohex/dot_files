;;;; editing operations
;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu2-query-replace-regexp)
(global-set-key (kbd "ESC M-%") 'anzu2-query-replace-at-cursor)
(global-set-key (kbd "C-x %") 'anzu2-replace-at-cursor-thing)
(define-key isearch-mode-map [remap isearch-query-replace]  #'anzu2-isearch-query-replace)
(define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu2-isearch-query-replace-regexp)

;; anzu
(global-anzu2-mode +1)
(custom-set-variables
 '(anzu2-mode-lighter ""))

;; electrict-mode
(custom-set-variables
 '(electric-indent-mode nil))

(defvar my/electric-pair-enabled-modes
  '(c-mode
    c++-mode
    objc-mode
    java-mode
    python-mode
    ruby-mode
    sh-mode
    js-mode
    go-mode
    css-mode
    cmake-mode
    cperl-mode
    markdown-mode
    gfm-mode
    sql-mode))

(dolist (mode my/electric-pair-enabled-modes)
  (add-hook (intern (concat (symbol-name mode) "-hook")) #'electric-pair-local-mode))
