;;;; global key setting

;; my key mapping
(global-set-key (kbd "M-ESC ESC") 'keyboard-quit)
(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key (kbd "M-*") 'tags-loop-continue)
(global-set-key (kbd "<f11>") 'my/open-task-memo)
(global-set-key (kbd "<f10>") 'my/open-daily-memo)
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'editutil-edit-next-line-no-indent)
(global-set-key (kbd "C-h e") 'popwin:messages)
(global-set-key (kbd "C-M-y") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x ?") 'zeal-at-point)
(global-set-key (kbd "M-K") 'kill-whole-line)

;; helm binding
(global-set-key (kbd "M-.") 'my/helm-etags-select)
(global-set-key (kbd "C-M-z")   'helm-resume)
(global-set-key (kbd "C-x C-x") 'helm-find-files)
(global-set-key (kbd "C-x C-p") 'my/helm-git-project-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-l") 'helm-locate)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-h a")   'helm-apropos)
(global-set-key (kbd "C-h m")   'helm-man-woman)
(global-set-key (kbd "C-x .")   'helm-ag-this-file)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-x b")   'helm-buffers-list)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)

;; col-highlight
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)

(define-key my/ctrl-q-map (kbd "h") 'ac-last-quick-help)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'flyspell-mode)
(define-key my/ctrl-q-map (kbd "C-m") 'my/toggle-flymake)
(define-key my/ctrl-q-map (kbd "C-t") 'toggle-cleanup-spaces)
(define-key my/ctrl-q-map (kbd "\\") 'align)
(define-key my/ctrl-q-map (kbd "l") 'editutil-copy-line)
(define-key my/ctrl-q-map (kbd ".") 'highlight-symbol-at-point)
(define-key my/ctrl-q-map (kbd "?") 'highlight-symbol-remove-all)
(define-key my/ctrl-q-map (kbd "s") 'editutil-unwrap-at-point)
(define-key my/ctrl-q-map (kbd "r") 'editutil-replace-wrapped-string)

(smartrep-define-key
    global-map "C-q" '(("<" . 'winner-undo)
                       (">" . 'winner-redo)))

(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

(smartrep-define-key
    global-map "C-c" '(("+" . 'evil-numbers/inc-at-pt)
                       ("-" . 'evil-numbers/dec-at-pt)))

;; M-g mapping
(global-set-key (kbd "M-g M-q") 'quickrun)
(global-set-key (kbd "M-g M-w") 'quickrun-with-arg)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "M-g M-i") 'import-popwin)
(global-set-key (kbd "M-g M-f") 'ffap)
(global-set-key (kbd "M-g M-m") 'my/flymake-popup-error-message)
(global-set-key (kbd "M-g M-l") 'my/flycheck-list-errors)

;;; buffer-move
(global-set-key (kbd "M-g h") 'buf-move-left)
(global-set-key (kbd "M-g j") 'buf-move-down)
(global-set-key (kbd "M-g k") 'buf-move-up)
(global-set-key (kbd "M-g l") 'buf-move-right)
