;;;; global key setting
(global-set-key (kbd "M-ESC ESC") 'read-only-mode)
(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key (kbd "M-*") 'tags-loop-continue)
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "C-M-l") 'goto-line)
(global-set-key (kbd "M-=") 'yas-insert-snippet)
(global-set-key (kbd "C-x C-o") 'org-capture)
(global-set-key (kbd "C-x z") 'zoom-window-zoom)

;; unset keys
(global-unset-key (kbd "C-x C-n"))

;; helm binding
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-h m") 'helm-man-woman)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-`") 'helm-ispell)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)

(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'flyspell-mode)
(define-key my/ctrl-q-map (kbd "C-m") 'flycheck-mode)

(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

(smartrep-define-key
    undo-tree-map "C-x" '(("u" . 'undo-tree-undo)
                          ("U" . 'undo-tree-redo)))

;; editutil mappings
(editutil-default-setup)
(global-set-key (kbd "C-x c") ctl-x-4-map)
(global-set-key (kbd "C-x c j") 'dired-jump-other-window)
(global-set-key (kbd "C-x c y") 'clipboard-yank)

;; M-g mapping
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "M-g p") 'helm-ag-project-root)
(global-set-key (kbd "M-g M-i") 'import-popwin)
(global-set-key (kbd "M-g M-f") 'ffap)
(global-set-key (kbd "M-g M-l") 'my/flycheck-list-errors)
(global-set-key (kbd "M-g r") #'recompile)
(global-set-key (kbd "M-g q") #'quickrun)

;;; buffer-move
(global-set-key (kbd "M-g h") 'buf-move-left)
(global-set-key (kbd "M-g j") 'buf-move-down)
(global-set-key (kbd "M-g k") 'buf-move-up)
(global-set-key (kbd "M-g l") 'buf-move-right)
