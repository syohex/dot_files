;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'newline-and-indent)

;; helm binding
(global-set-key (kbd "C-x C-a")    'helm-buffers-list)
(global-set-key (kbd "C-x C-w")    'helm-resume)
(global-set-key (kbd "C-x C-c")    'helm-M-x)
(global-set-key (kbd "M-y")        'helm-show-kill-ring)
(global-set-key (kbd "C-h a")      'helm-c-apropos)
(global-set-key (kbd "C-x C-i")    'helm-imenu)
(global-set-key (kbd "C-M-s")      'helm-occur)
(global-set-key (kbd "M--")        'helm-buffers-list)

;;; switch last-buffer
(defun switch-to-last-buffer ()
  (interactive)
  (loop for buf in (cdr (buffer-list))
        when (and (not (string-match "^\s*\\*" (buffer-name buf)))
                  (and (buffer-file-name buf)
                       (not (file-directory-p (buffer-file-name buf)))))
        return (switch-to-buffer buf)))

(global-set-key (kbd "M-0") 'switch-to-last-buffer)

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
(require 'col-highlight)
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd ".") 'quick-jump-push-marker)
(define-key my/ctrl-q-map (kbd ",") 'quick-jump-go-back)

;; for scroll other window
(smartrep-define-key
    global-map "C-q" '(("n" . (scroll-other-window 1))
                       ("p" . (scroll-other-window -1))
                       ("N" . 'scroll-other-window)
                       ("P" . (scroll-other-window '-))
                       ("a" . (beginning-of-buffer-other-window 0))
                       ("e" . (end-of-buffer-other-window 0))))

;; repeat yank. Because C-y can't accept `C-u Number' prefix
(defun repeat-yank (num)
  (interactive "NRepeat Count > ")
  (dotimes (i num)
    (yank)
    (insert "\n")))
(define-key my/ctrl-q-map (kbd "y") 'repeat-yank)
(global-set-key (kbd "M-g y") 'repeat-yank)

;; M-g mapping
(global-set-key (kbd "M-g M-g") 'simple-grep)

(global-set-key (kbd "M-g C-f") 'ffap)
(global-set-key (kbd "M-g <backspace>") 'delete-region)

;; for move PARAGRAPH
(smartrep-define-key
    global-map "M-g" '(("[" . (backward-paragraph))
                       ("]" . (forward-paragraph))))

;; like Vim's 'f'
(defun forward-match-char (n)
  (interactive "p")
  (let ((c (read-char)))
    (dotimes (i n)
      (forward-char)
      (skip-chars-forward (format "^%s" (char-to-string c))))))

(defun backward-match-char (n)
  (interactive "p")
  (let ((c (read-char)))
    (dotimes (i n)
      (skip-chars-backward (format "^%s" (char-to-string c)))
      (backward-char))))

(global-set-key (kbd "M-g f") 'forward-match-char)
(global-set-key (kbd "M-g F") 'backward-match-char)

;; copy, kill operations
(global-set-key (kbd "M-g s") 'copy-symbol)
(global-set-key (kbd "M-g w") 'copy-word)

;; for bm-next, bm-previous
(global-set-key (kbd "M-g @") 'bm-toggle)
(smartrep-define-key
    global-map "M-g" '((">" . (bm-next))
                       ("<" . (bm-previous))))

;; quick-jump
(global-set-key (kbd "M-g .") 'quick-jump-push-marker)
(global-set-key (kbd "M-g ,") 'quick-jump-go-back)

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
