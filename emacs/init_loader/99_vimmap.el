;;;; Like Vim Key mapping

;; 'C-z prefix'
(defvar ctrl-z-map (if (featurep 'elscreen)
                       elscreen-map
                     (make-sparse-keymap)))
(defalias 'ctrl-z-prefix ctrl-z-map)
(define-key global-map (kbd "C-z") 'ctrl-z-prefix)

;; Deletion('C-z d' prefix)
(defvar ctrl-z-d-map (make-sparse-keymap)
  "Key map for subcommands of C-z d")
(defalias 'ctrl-z-d-prefix ctrl-z-d-map)
(define-key ctrl-z-map (kbd "d") 'ctrl-z-d-prefix)

(define-key ctrl-z-d-map (kbd "d") 'kill-whole-line)
(define-key ctrl-z-d-map (kbd "w") 'kill-word)
(define-key ctrl-z-d-map (kbd "s") 'kill-string)
(define-key ctrl-z-d-map (kbd "$") 'kill-line)

(defun my/delete-to-char ()
  (interactive)
  (let ((chr (read-char "Delete to: ")))
    (unless chr
      (error "Please input character"))
    (save-excursion
      (let ((cur-point (point))
            (del-point (or (search-forward (char-to-string chr) nil t))))
        (delete-region cur-point (1- del-point))))))
(define-key ctrl-z-d-map (kbd "f") 'my/delete-to-char)

;; Copying('C-z y' prefix)
(defvar ctrl-z-y-map (make-sparse-keymap)
  "Key map for subcommands of C-z y")
(defalias 'ctrl-z-y-prefix ctrl-z-y-map)
(define-key ctrl-z-map (kbd "y") 'ctrl-z-y-prefix)

(define-key ctrl-z-y-map (kbd "w") 'copy-word)
(define-key ctrl-z-y-map (kbd "s") 'copy-string)

(defun my/copy-line (arg)
  (interactive "p")
  (save-excursion
    (beginning-of-line)
    (let ((start (point)))
      (forward-line arg)
      (kill-ring-save start (point)))))
(define-key ctrl-z-y-map (kbd "y") 'my/copy-line)

;; Insert next line and previous line('o' and 'O')
(defun edit-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun edit-previous-line ()
  (interactive)
  (forward-line -1)
  (if (not (= (line-number-at-pos) 1))
      (end-of-line))
  (newline-and-indent))

(define-key ctrl-z-map (kbd "o") 'edit-next-line)
(define-key ctrl-z-map (kbd "O") 'edit-previous-line)

;; Move matched paren('%')
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))
(define-key ctrl-z-map (kbd "%") 'goto-match-paren)

;; paste
(defun repeat-yank (arg)
  (interactive "p")
  (dotimes (i arg)
    (yank)))
(define-key ctrl-z-map (kbd "p") 'repeat-yank)

;; Move next searched char('f')
(defun forward-match-char (arg)
  (interactive "p")
  (let ((c (read-char)))
    (dotimes (i arg)
      (forward-char)
      (skip-chars-forward (format "^%s" (char-to-string c))))))

(defun backward-match-char (arg)
  (interactive)
  (let ((c (read-char)))
    (dotimes (i arg)
      (skip-chars-backward (format "^%s" (char-to-string c)))
      (backward-char))))

(define-key ctrl-z-map (kbd "f") 'forward-match-char)
(define-key ctrl-z-map (kbd "F") 'backward-match-char)

;; paragraph moving('[' and ']')
(smartrep-define-key
    global-map "C-z" '(("[" . 'backward-paragraph)
                       ("]" . 'forward-paragraph)))

;; move point('C-o' and 'C-i')
(smartrep-define-key
    global-map "C-z" '(("C-o" . 'goto-last-change)
                       ("C-i" . 'goto-last-change-reverse)))
