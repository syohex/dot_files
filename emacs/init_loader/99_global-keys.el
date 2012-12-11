;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'newline-and-indent)

;; helm binding
(global-set-key (kbd "C-M-z")   'helm-resume)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-h a")   'helm-c-apropos)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-M-s")   'helm-occur)
(global-set-key (kbd "C-x b")   'helm-buffers-list)

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
(defun repeat-yank (arg)
  (interactive "p")
  (dotimes (i arg)
    (yank)))
(define-key my/ctrl-q-map (kbd "p") 'repeat-yank)

(defun my/upcase-previous-word (arg)
  (interactive "p")
  (backward-word arg)
  (upcase-word arg))
(define-key my/ctrl-q-map (kbd "u") 'my/upcase-previous-word)

(require 'col-highlight)
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "w") 'copy-word)
(define-key my/ctrl-q-map (kbd "k") 'kill-whole-line)
(define-key my/ctrl-q-map (kbd "C-f") 'ffap)
(define-key my/ctrl-q-map (kbd "C-p") 'pomodoro:start)
(define-key my/ctrl-q-map (kbd "|") 'winner-undo)
(define-key my/ctrl-q-map (kbd "r") '(lambda ()
                                       (interactive)
                                       (revert-buffer nil t)))

(defun my/align-command ()
  (interactive)
  (if current-prefix-arg
      (let ((current-prefix-arg nil))
        (call-interactively 'align-regexp))
    (call-interactively 'align)))
(define-key my/ctrl-q-map (kbd "\\") 'my/align-command)

(defun swap-buffers ()
  (interactive)
  (let ((curwin (selected-window))
        (curbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer curwin (window-buffer))
    (set-window-buffer (selected-window) curbuf)))
(define-key my/ctrl-q-map (kbd "b") 'swap-buffers)

(defun my/dict ()
  (interactive)
  (let ((word (read-string "Word: " (thing-at-point 'word))))
    (with-current-buffer (get-buffer-create "*dict*")
      (erase-buffer)
      (let* ((cmd (format "dict %s" word))
             (ret (call-process-shell-command cmd nil t)))
        (unless (= ret 0)
          (error ("Failed command: %s")))
        (pop-to-buffer (get-buffer "*dict*"))
        (goto-char (point-min))))))
(define-key my/ctrl-q-map (kbd "C-d") 'my/dict)

;; M-g mapping
(global-set-key (kbd "M-g .") 'helm-ack)
(global-set-key (kbd "M-g ,") 'helm-ack-pop-stack)

;; duplicate current line
(defun duplicate-thing (n)
  (interactive "p")
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
  (forward-line 1))

(smartrep-define-key
    global-map "M-g" '(("c" . duplicate-thing)))
