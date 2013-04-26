;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'newline-and-indent)

;; helm binding
(global-set-key (kbd "C-M-z")   'helm-resume)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-h a")   'helm-apropos)
(global-set-key (kbd "C-h m")   'helm-man-woman)
(global-set-key (kbd "C-x C-z") 'helm-occur)
(global-set-key (kbd "C-h e")   'popwin:messages)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-x b")   'helm-buffers-list)
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)

(defun my/copy-line ()
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position)))
(define-key my/ctrl-q-map (kbd "l") 'my/copy-line)

;; paste
(defun my/repeat-yank (arg)
  (interactive "p")
  (dotimes (i arg)
    (yank)))
(define-key my/ctrl-q-map (kbd "y") 'my/repeat-yank)

;; col-highlight
(autoload 'col-highlight-mode "col-highlight" nil t)
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)

(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'flyspell-mode)
(define-key my/ctrl-q-map (kbd "|") 'winner-undo)
(define-key my/ctrl-q-map (kbd "C-b") 'helm-bookmarks)
(define-key my/ctrl-q-map (kbd "C-t") 'toggle-cleanup-spaces)
(define-key my/ctrl-q-map (kbd "\\") 'align)
(define-key my/ctrl-q-map (kbd "p") (lambda () (interactive) (push-mark)))

(defun my/swap-buffers ()
  (interactive)
  (when (one-window-p)
    (error "Frame is not splitted!!"))
  (let ((curwin (selected-window))
        (curbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer curwin (window-buffer))
    (set-window-buffer (selected-window) curbuf)))
(define-key my/ctrl-q-map (kbd "b") 'my/swap-buffers)

(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

;; M-g mapping
(global-set-key (kbd "M-g M-q") 'quickrun)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "M-g M-i") 'import-popwin)
(global-set-key (kbd "M-g M-f") 'ffap)

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

;; flymake
(defun my/flymake-goto-next-error (arg)
  (interactive "P")
  (if (and (boundp 'flycheck-mode) flycheck-mode)
      (next-error arg)
    (flymake-goto-next-error)))

(defun my/flymake-goto-previous-error (arg)
  (interactive "P")
  (if (and (boundp 'flycheck-mode) flycheck-mode)
      (previous-error arg)
    (flymake-goto-prev-error)))

(smartrep-define-key
    global-map "M-g" '(("M-n" . 'my/flymake-goto-next-error)
                       ("M-p" . 'my/flymake-goto-previous-error)))

(defun open-junk ()
  (interactive)
  (let ((filename (read-file-name "Junk File: " "~/junk/")))
    (find-file filename)))
