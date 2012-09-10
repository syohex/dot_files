;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'newline-and-indent)
(global-set-key (kbd "M-C-SPC") 'mark-sexp*)

;; helm binding
(global-set-key (kbd "C-x C-w")    'helm-resume)
(global-set-key (kbd "C-x C-r")    'helm-recentf)
(global-set-key (kbd "C-x C-a")    'helm-bookmarks)
(global-set-key (kbd "C-x C-c")    'helm-M-x)
(global-set-key (kbd "M-y")        'helm-show-kill-ring)
(global-set-key (kbd "C-h a")      'helm-c-apropos)
(global-set-key (kbd "C-x C-i")    'helm-imenu)
(global-set-key (kbd "C-M-r")      'helm-imenu)
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
(define-key my/ctrl-q-map (kbd "w") 'mark-word*)
(define-key my/ctrl-q-map (kbd "s") 'mark-symbol)
(define-key my/ctrl-q-map (kbd "DEL") 'kill-whole-line)
(define-key my/ctrl-q-map (kbd "C-p") 'pomodoro:start)

;; quick-jump setting
(define-key my/ctrl-q-map (kbd "<SPC>") 'quick-jump-push-marker)
(smartrep-define-key
    global-map "C-q" '(("<" . (call-interactively 'quick-jump-go-back))
                       (">" . (call-interactively 'quick-jump-go-forward))))

(smartrep-define-key
    global-map "C-q" '(("[" . (call-interactively 'backward-paragraph))
                       ("]" . (call-interactively 'forward-paragraph))))

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
