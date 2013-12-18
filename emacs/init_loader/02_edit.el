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
     (set-face-foreground 'ace-jump-face-foreground "lime green")
     (set-face-bold-p 'ace-jump-face-foreground t
                      (set-face-underline-p 'ace-jump-face-foreground t))))

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
     (let ((disabled '("M-<backspace>")))
       (setq sp-smartparens-bindings
             (remove-if (lambda (key-command)
                          (member (car key-command) disabled))
                        sp-smartparens-bindings)))))

(dolist (mode my/smartparens-enabled-modes)
  (add-hook (intern (format "%s-hook" mode)) 'my/enable-smartparens-mode))

;; highlight specified words
(defun my/add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|TODO\\|XXX\\|@@@\\)\\>"
          1 '((:foreground "pink") (:weight bold)) t))))

(add-hook 'prog-mode-hook 'my/add-watchwords)

;; editutil
(require 'editutil)

(global-set-key [(control shift up)] 'editutil-move-line-up)
(global-set-key [(control shift down)] 'editutil-move-line-down)

(global-set-key (kbd "C-M-s") 'editutil-forward-char)
(global-set-key (kbd "C-M-r") 'editutil-backward-char)

(global-set-key (kbd "M-o") 'editutil-edit-next-line)
(global-set-key (kbd "M-O") 'editutil-edit-previous-line)

(global-set-key (kbd "M-s") 'editutil-unwrap-at-point)
(global-set-key (kbd "M-r") 'editutil-replace-wrapped-string)
(global-set-key (kbd "M-z") 'editutil-zap-to-char)

(global-set-key (kbd "M-n") 'editutil-next-symbol)
(global-set-key (kbd "M-p") 'editutil-previous-symbol)

(global-set-key (kbd "M-k") 'editutil-delete-following-spaces)

(global-set-key (kbd "C-y") 'editutil-yank)

(global-set-key (kbd "M-d") 'editutil-delete-word)
(global-set-key (kbd "M-<backspace>") 'editutil-backward-delete-word)

(global-set-key (kbd "C-x r N") 'editutil-number-rectangle)

(global-set-key (kbd "C-M-SPC") 'editutil-copy-sexp)

(smartrep-define-key
    global-map "C-x" '(("j" . 'editutil-insert-newline-without-moving)))

(smartrep-define-key
    global-map "M-g" '(("c" . 'editutil-duplicate-thing)))
