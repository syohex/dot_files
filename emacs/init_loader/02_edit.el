;;;; editing operations
;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "C-x M-%") 'anzu-query-replace-at-cursor)
(global-set-key (kbd "C-x %") 'anzu-replace-at-cursor-thing)

;; thingopt
(require 'thingopt)
(define-thing-commands)

;; electrict-mode
(custom-set-variables
 '(electric-indent-mode nil))

;; autopair
(custom-set-variables
 '(autopair-blink nil)
 '(autopair-blink-delay 0))

(defvar my/autopair-enabled-modes
  '(c-mode
    c++-mode
    java-mode
    python-mode
    ruby-mode
    erlang-mode
    prolog-mode
    haskell-mode
    inferior-haskell-mode
    sh-mode
    js-mode
    go-mode
    coffee-mode
    cperl-mode))

(dolist (mode my/autopair-enabled-modes)
  (add-hook (intern (format "%s-hook" mode)) 'autopair-mode))

;; highlight specified words
(defun my/add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\_<\\(FIXME\\|TODO\\|XXX\\|@@@\\)\\_>"
          1 '((:foreground "pink") (:weight bold)) t))))

(add-hook 'prog-mode-hook 'my/add-watchwords)

;; editutil
(require 'editutil)
(editutil-default-setup)
