;;;; global key setting
(global-set-key (kbd "M-,") #'pop-tag-mark)
(global-set-key (kbd "M-*") #'tags-loop-continue)
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-=") 'yas-insert-snippet)
(global-set-key (kbd "C-x z") #'zoom-window2-zoom)
(global-set-key (kbd "C-x RET R") #'revert-buffer)
(global-set-key (kbd "C-x j") #'jump-to-register)
(global-set-key (kbd "C-x SPC") #'point-to-register)
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; unset keys
(global-unset-key (kbd "C-x C-n"))

;; helm binding
(global-set-key (kbd "C-M-z") #'helm-resume)
(global-set-key (kbd "C-x C-c") #'helm-M-x)
(global-set-key (kbd "C-M-y") #'helm-show-kill-ring)
(global-set-key (kbd "C-h a") #'helm-apropos)
(global-set-key (kbd "C-h m") #'helm-man-woman)
(global-set-key (kbd "C-x C-i") #'helm-imenu)
(global-set-key (kbd "C-x b") #'helm-buffers-list)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)

(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'flyspell-mode)

(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

;; editutil mappings
(editutil-default-setup)
(global-set-key (kbd "C-x c") ctl-x-4-map)

;; M-g mapping
(global-set-key (kbd "M-g .") #'helm-ag2)
(global-set-key (kbd "M-g ,") #'helm-ag2-pop-stack)
(global-set-key (kbd "M-g p") #'helm-ag2-project-root)
(global-set-key (kbd "M-g f") #'helm-do-ag2-this-file)
(global-set-key (kbd "M-g r") #'recompile)
(global-set-key (kbd "M-g q") #'quickrun2)

;;; buffer-move
(global-set-key (kbd "M-g h") #'buf-move-left)
(global-set-key (kbd "M-g j") #'buf-move-down)
(global-set-key (kbd "M-g k") #'buf-move-up)
(global-set-key (kbd "M-g l") #'buf-move-right)

(when (memq window-system '(mac ns))
 (add-to-list 'default-frame-alist '(ns-appearance . 'dark))
 (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))
