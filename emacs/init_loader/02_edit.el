;;;; editing operations
;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "C-x M-%") 'anzu-query-replace-at-cursor)
(global-set-key (kbd "C-x %") 'anzu-query-replace-at-cursor-thing)

;; thingopt
(require 'thingopt)
(define-thing-commands)

;; moving with ace-jump-mode
(eval-after-load "ace-jump-mode"
  '(progn
     (setq ace-jump-mode-case-fold nil)
     (set-face-attribute 'ace-jump-face-foreground nil
                         :foreground "LimeGreen" :weight 'bold)))

;; electrict-mode
(custom-set-variables
 '(electric-indent-mode nil))

;; smartparens
(custom-set-variables
 '(sp-highlight-pair-overlay nil)
 '(sp-highlight-wrap-overlay nil)
 '(sp-highlight-wrap-tag-overlay nil))

(defvar my/smartparens-enabled-modes
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

(defun my/enable-smartparens-mode ()
  (smartparens-mode +1)
  (sp-use-smartparens-bindings))

(eval-after-load "smartparens"
  '(progn
     (let ((disabled '("M-<backspace>" "C-M-n" "C-M-p" "C-M-a" "C-M-e")))
       (setq sp-smartparens-bindings
             (remove-if (lambda (key-command)
                          (member (car key-command) disabled))
                        sp-smartparens-bindings)))))

(dolist (mode my/smartparens-enabled-modes)
  (add-hook (intern (format "%s-hook" mode)) 'my/enable-smartparens-mode))

;; highlight specified words
(defun my/add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\_<\\(FIXME\\|TODO\\|XXX\\|@@@\\)\\_>"
          1 '((:foreground "pink") (:weight bold)) t))))

(add-hook 'prog-mode-hook 'my/add-watchwords)

;; editutil
(require 'editutil)
(editutil-default-setup)
