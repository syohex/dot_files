;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'newline-and-indent)
(global-set-key (kbd "M-C-SPC") 'mark-sexp*)
(global-set-key (kbd "C-M-w") 'kill-symbol)
(global-set-key (kbd "C-M-r") 'copy-list*)

;; helm binding
(global-set-key (kbd "C-M-z")      'helm-resume)
(global-set-key (kbd "C-x C-r")    'my/helm-recentf)
(global-set-key (kbd "C-x C-c")    'helm-M-x)
(global-set-key (kbd "M-y")        'helm-show-kill-ring)
(global-set-key (kbd "C-h a")      'helm-c-apropos)
(global-set-key (kbd "C-x C-i")    'helm-imenu)
(global-set-key (kbd "C-M-s")      'helm-occur)
(global-set-key (kbd "C-x b")      'helm-buffers-list)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)

(defun my/copy-line ()
  (interactive)
  (save-excursion
    (let (start)
      (beginning-of-line)
      (setq start (point))
      (end-of-line)
      (kill-ring-save start (point)))))

(define-key my/ctrl-q-map (kbd "l") 'my/copy-line)

(defun my/upcase-previous-word (arg)
  (interactive "p")
  (backward-word arg)
  (upcase-word arg))
(define-key my/ctrl-q-map (kbd "u") 'my/upcase-previous-word)

(require 'col-highlight)
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "w") 'copy-word*)
(define-key my/ctrl-q-map (kbd "s") 'copy-symbol)
(define-key my/ctrl-q-map (kbd "m") 'copy-string)
(define-key my/ctrl-q-map (kbd "f") 'helm-flymake)
(define-key my/ctrl-q-map (kbd "C-f") 'ffap)
(define-key my/ctrl-q-map (kbd "DEL") 'delete-region)
(define-key my/ctrl-q-map (kbd "C-p") 'pomodoro:start)

(defun my/align-command ()
  (interactive)
  (if current-prefix-arg
      (let ((current-prefix-arg nil))
        (call-interactively 'align-regexp))
    (call-interactively 'align)))
(define-key my/ctrl-q-map (kbd "\\") 'my/align-command)

(defun my/copy-to-end-of-line ()
  (interactive)
  (kill-ring-save (point) (point-at-eol)))
(define-key my/ctrl-q-map (kbd "k") 'my/copy-to-end-of-line)

(defun my/delete-to-char ()
  (interactive)
  (let ((chr (read-char "Delete to: ")))
    (unless chr
      (error "Please input character"))
   (save-excursion
     (let ((cur-point (point))
           (del-point (or (search-forward (char-to-string chr) nil t))))
       (delete-region cur-point (1- del-point))))))
(define-key my/ctrl-q-map (kbd "d") 'my/delete-to-char)

;; goto-chg setting
(smartrep-define-key
    global-map "C-q" '(("<" . 'goto-last-change)
                       (">" . 'goto-last-change-reverse)))

(smartrep-define-key
   global-map "C-q" '(("[" . 'backward-paragraph)
                      ("]" . 'forward-paragraph)))

;; repeat yank. Because C-y can't accept `C-u Number' prefix
(defun repeat-yank (num)
  (interactive "NRepeat Count > ")
  (dotimes (i num)
    (yank)
    (insert "\n")))
(define-key my/ctrl-q-map (kbd "y") 'repeat-yank)
(global-set-key (kbd "M-g y") 'repeat-yank)

;; M-g mapping
(global-set-key (kbd "M-g .") 'helm-ack)
(global-set-key (kbd "M-g ,") 'helm-ack-pop-stack)

;; for bm-next, bm-previous
(global-set-key (kbd "M-g @") 'bm-toggle)
(smartrep-define-key
    global-map "M-g" '((">" . (bm-next))
                       ("<" . (bm-previous))))

;; duplicate current line
(defun duplicate-thing (n)
  (interactive "p")
  (save-excursion
    (let (start end)
      (cond (mark-active
             (setq start (region-beginning) end (region-end)))
            (t
             (beginning-of-line)
             (setq start (point))
             (forward-line)
             (setq end (point))))
      (kill-ring-save start end)
      (dotimes (i (or n 1))
        (yank)))))

(smartrep-define-key
    global-map "M-g" '(("c" . (call-interactively 'duplicate-thing))))
