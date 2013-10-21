;;;; global key setting

;; my key mapping
(global-set-key (kbd "M-,") 'pop-tag-mark)
(global-set-key (kbd "M-*") 'tags-loop-continue)
(global-set-key (kbd "<f11>") 'my/open-task-memo)
(global-set-key (kbd "<f10>") 'my/open-daily-memo)
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'my/edit-next-line-no-indent)
(global-set-key (kbd "C-h e")   'popwin:messages)
(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C-M-y") '(lambda () (interactive) (other-window -1)))

(global-unset-key (kbd "C-x q"))
(global-set-key (kbd "C-x q C-f") 'find-file-other-window)
(global-set-key (kbd "C-x q C-b") 'switch-to-buffer-other-window)
(global-set-key (kbd "C-x q C-j") 'dired-jump-other-window)

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

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)
(defun my/copy-line ()
  (interactive)
  (let ((n (if current-prefix-arg 1 0)))
    (kill-ring-save (line-beginning-position) (+ n (line-end-position)))))
(define-key my/ctrl-q-map (kbd "l") 'my/copy-line)

;; col-highlight
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)

(define-key my/ctrl-q-map (kbd "h") 'ac-last-quick-help)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'flyspell-mode)
(define-key my/ctrl-q-map (kbd "C-m") 'my/toggle-flymake)
(define-key my/ctrl-q-map (kbd "k") 'kill-whole-line)
(define-key my/ctrl-q-map (kbd "C-t") 'toggle-cleanup-spaces)
(define-key my/ctrl-q-map (kbd "\\") 'align)
(define-key my/ctrl-q-map (kbd "C-k") 'kill-whole-line)
(define-key my/ctrl-q-map (kbd ".") 'highlight-symbol-at-point)
(define-key my/ctrl-q-map (kbd "?") 'highlight-symbol-remove-all)

(defun my/highlight-symbol-query-replace-in-defun (replacement)
  (interactive (let ((symbol (or (thing-at-point 'symbol)
                                 (error "No symbol at point"))))
                 (highlight-symbol-temp-highlight)
                 (set query-replace-to-history-variable
                      (cons (substring-no-properties symbol)
                            (eval query-replace-to-history-variable)))
                 (list
                  (read-from-minibuffer "Replacement: " nil nil nil
                                        query-replace-to-history-variable))))
  (goto-char (beginning-of-thing 'symbol))
  (let ((start (save-excursion (beginning-of-defun) (point)))
        (end (save-excursion (end-of-defun) (point)))
        (symbol (highlight-symbol-get-symbol)))
    (query-replace-regexp symbol replacement nil start end)
    (highlight-symbol-remove-symbol symbol)))
(define-key my/ctrl-q-map (kbd "%") 'my/highlight-symbol-query-replace-in-defun)

(smartrep-define-key
    global-map "C-q" '((">" . 'highlight-symbol-next)
                       ("<" . 'highlight-symbol-prev)))

(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

(smartrep-define-key
    global-map "C-c" '(("+" . 'evil-numbers/inc-at-pt)
                       ("-" . 'evil-numbers/dec-at-pt)))

;; resize window
(smartrep-define-key
    global-map "C-q" '(("H" . 'shrink-window-horizontally)
                       ("L" . 'enlarge-window-horizontally)))

(defun my/enlarge-window-down (arg)
  (interactive "p")
  (enlarge-window (- arg)))

(smartrep-define-key
    global-map "C-q" '(("J" . 'enlarge-window)
                       ("K" . 'my/enlarge-window-down)))

(define-key my/ctrl-q-map (kbd "<SPC>") 'point-to-register)
(define-key my/ctrl-q-map (kbd "j") 'jump-to-register)

;; Vim's '*'
(defun my/search-at-word ()
  (interactive)
  (let ((start (if (looking-at "\\<")
                   (point)
                 (save-excursion
                   (backward-word 1)
                   (point))))
        (end (save-excursion
               (forward-word 1)
               (point))))
    (kill-ring-save start end)
    (isearch-mode t nil nil nil)
    (isearch-yank-pop)))
(define-key my/ctrl-q-map (kbd "C-s") 'my/search-at-word)

;; M-g mapping
(global-set-key (kbd "M-g M-q") 'quickrun)
(global-set-key (kbd "M-g M-w") 'quickrun-with-arg)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "M-g M-i") 'import-popwin)
(global-set-key (kbd "M-g M-f") 'ffap)
(global-set-key (kbd "M-g M-m") 'flymake-display-err-menu-for-current-line)

;;; buffer-move
(global-set-key (kbd "M-g h") 'buf-move-left)
(global-set-key (kbd "M-g j") 'buf-move-down)
(global-set-key (kbd "M-g k") 'buf-move-up)
(global-set-key (kbd "M-g l") 'buf-move-right)

;; duplicate current line
(defun my/duplicate-thing (n)
  (interactive "p")
  (let ((orig-column (current-column))
        (lines (if mark-active
                   (1+ (- (line-number-at-pos (region-end))
                          (line-number-at-pos (region-beginning))))
                 1)))
    (save-excursion
      (let ((orig-line (line-number-at-pos))
            (str (if mark-active
                     (buffer-substring (region-beginning) (region-end))
                   (buffer-substring (line-beginning-position)
                                     (line-end-position)))))
        (forward-line 1)
        ;; maybe last line
        (when (= orig-line (line-number-at-pos))
          (insert "\n"))
        (dotimes (i (or n 1))
          (insert str "\n"))))
    (forward-line lines)
    (move-to-column orig-column)))

(smartrep-define-key
    global-map "M-g" '(("c" . my/duplicate-thing)))
