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
(global-set-key [C-backspace] 'backward-M-delete-word)
(global-set-key (kbd "M-DEL") 'backward-delete-word)

;; duplicate current line
(defun duplicate-current-line (&optional n)
  "duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((nb (or n 1))
          (current-line (thing-at-point 'line)))
      ;; when on last line, insert a newline first
      (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
        (insert "\n"))

      ;; now insert as many time as requested
      (while (> n 0)
        (insert current-line)
        (decf n)))))

(global-set-key (kbd "C-S-d") 'duplicate-current-line)

;; moving match paren
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

;; Symbol mapping(movind, deleting ...)
(global-set-key (kbd "M-F") 'forward-symbol)
(global-set-key (kbd "M-B") (lambda (arg)
                              (interactive "p")
                              (forward-symbol (- arg))))

;;;; jaunte hit-a-hint
;; (auto-install-from-url "https://raw.github.com/kawaguchi/jaunte.el/master/jaunte.el")
(require 'jaunte)
(setq-default jaunte-hint-unit 'whitespace)

;;;; jump by one character
;; (auto-install-from-url "https://raw.github.com/winterTTr/ace-jump-mode/master/ace-jump-mode.el")
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; edit rectangle
;; number-rectangle
(eval-when-compile (require 'cl))
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

(global-set-key "\C-xrN" 'number-rectangle)
