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

(global-set-key (kbd "M-c") 'duplicate-thing)

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

;; edit rectangle
;; number-rectangle
(defun number-rectangle (start end format-string from)
  "Delete (don't save) text in the region-rectangle, then number it."
  (interactive
   (list (region-beginning) (region-end)
         (read-string "Number rectangle: " (if (looking-back "^ *") "%d. " "%d"))
         (read-number "From: " 1)))
  (save-excursion
    (goto-char start)
    (setq start (point-marker))
    (goto-char end)
    (setq end (point-marker))
    (delete-rectangle start end)
    (goto-char start)
    (loop with column = (current-column)
          while (and (<= (point) end) (not (eobp)))
          for i from from   do
          (move-to-column column t)
          (insert (format format-string i))
          (forward-line 1)))
  (goto-char start))

(global-set-key (kbd "C-x r N") 'number-rectangle)

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

;; goto last-chg
(require 'goto-chg)
(global-set-key (kbd "M-z") 'goto-last-change)

;; moving with ace-jump-mode
(require 'ace-jump-mode)
(set-face-foreground 'ace-jump-face-foreground "lime green")
(set-face-bold-p 'ace-jump-face-foreground t)
(set-face-underline-p 'ace-jump-face-foreground t)

;; thingopt
(require 'thing-opt)
(define-thing-commands)

;; quick-jump
(require 'quick-jump)
