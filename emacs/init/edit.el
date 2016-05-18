;;;; editing operations
;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "ESC M-%") 'anzu-query-replace-at-cursor)
(global-set-key (kbd "C-x %") 'anzu-replace-at-cursor-thing)
(define-key isearch-mode-map [remap isearch-query-replace]  #'anzu-isearch-query-replace)
(define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu-isearch-query-replace-regexp)

;; electrict-mode
(custom-set-variables
 '(electric-indent-mode nil))

(defvar my/electric-pair-enabled-modes
  '(c-mode
    c++-mode
    java-mode
    python-mode
    ruby-mode
    erlang-mode
    elixir-mode
    prolog-mode
    haskell-mode
    inferior-haskell-mode
    sh-mode
    js-mode
    go-mode
    css-mode
    cmake-mode
    coffee-mode
    tuareg-mode
    tuareg-interactive-mode
    cperl-mode
    perl6-mode
    markdown-mode
    gfm-mode
    sql-mode))

(dolist (mode my/electric-pair-enabled-modes)
  (add-hook (intern (concat (symbol-name mode) "-hook")) #'electric-pair-local-mode))
