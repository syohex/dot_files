;; for word delete instead of kill-word and backward-kill-word
(defun delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  (interactive "p")
  (delete-word (- arg)))

(defun delete-cursor-word-or-region ()
  (interactive)
  (if (use-region-p)
      (call-interactively #'kill-region)
    (progn
      (backward-word)
      (delete-word 1))))

(global-set-key (kbd "C-w") 'delete-cursor-word-or-region)
(global-set-key (kbd "M-d") 'delete-word)
(global-set-key (kbd "M-DEL") 'backward-delete-word)

;; moving match paren
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))
(global-set-key (kbd "C-x %") 'goto-match-paren)

;; like Vim's "o"
(defun edit-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;; like Vim's "O(large 'o')"
(defun edit-previous-line ()
  (interactive)
  (forward-line -1)
  (if (not (= (current-line) 1))
      (end-of-line))
  (newline-and-indent))

(global-set-key (kbd "M-o") 'edit-next-line)
(global-set-key (kbd "M-O") 'edit-previous-line)

;; moving with ace-jump-mode
(require 'ace-jump-mode)
(set-face-foreground 'ace-jump-face-foreground "lime green")
(set-face-bold-p 'ace-jump-face-foreground t)
(set-face-underline-p 'ace-jump-face-foreground t)

;; thingopt
(require 'thing-opt)
(define-thing-commands)

(defun delete-cursor-symbol ()
  (interactive)
  (forward-symbol -1)
  (let ((start (point)))
    (forward-symbol 1)
    (delete-region start (point))))

(global-set-key (kbd "C-M-w") 'delete-cursor-symbol)

;; quick-jump
(require 'quick-jump)
