;;;; editing operations
;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)

;; kill buffer
(defun my/kill-buffer ()
  (interactive)
  (if (not current-prefix-arg)
      (call-interactively 'kill-buffer)
    (save-window-excursion
      (other-window 1)
      (let ((buf (current-buffer)))
        (when (y-or-n-p (format "kill buffer: %s" buf))
           (kill-buffer buf))))))
(global-set-key (kbd "C-x k") 'my/kill-buffer)

;; Vim's 'f', 'F'
(defun my/forward-to-char (arg char)
  (interactive "p\ncForward to char: ")
  (search-forward (char-to-string char) nil nil arg)
  (backward-char 1))

(defun my/backward-to-char (arg char)
  (interactive "p\ncBackward to char: ")
  (search-backward (char-to-string char) nil nil arg))

(global-set-key (kbd "C-x c f") 'my/forward-to-char)
(global-set-key (kbd "C-x c b") 'my/backward-to-char)

;; move lines
(defun my/move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun my/move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift up)] 'my/move-line-up)
(global-set-key [(control shift down)] 'my/move-line-down)

;; thingopt
(require 'thingopt)
(define-thing-commands)

;; copy sexp
(defun my/copy-sexp ()
  (interactive)
  (copy-sexp)
  (message "%s" (thing-at-point 'sexp)))
(global-set-key (kbd "M-C-SPC") 'my/copy-sexp)

;; delete-speces
(defun delete-following-spaces ()
  (interactive)
  (let ((orig-point (point)))
    (save-excursion
      (if current-prefix-arg
          (skip-chars-backward " \t")
        (skip-chars-forward " \t"))
      (delete-region orig-point (point)))))
(global-set-key (kbd "M-k") 'delete-following-spaces)

(defun my/join-line ()
  (interactive)
  (join-line -1))
(global-set-key (kbd "M-K") 'my/join-line)

;; for word delete instead of kill-word and backward-kill-word
(defun my/delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun my/delete-cursor-word-or-region ()
  (interactive)
  (if (use-region-p)
      (call-interactively #'kill-region)
    (progn
      (backward-word)
      (my/delete-word 1))))

(defun my/backward-kill-word (args)
  (interactive "p")
  (let ((from (save-excursion
                (forward-word -1)
                (point)))
        (limit (save-excursion
                 (back-to-indentation)
                 (point))))
    (cond ((bolp) (backward-kill-word args))
          (t
           (delete-region (max from limit) (point))))))

(global-set-key (kbd "C-w") 'my/delete-cursor-word-or-region)
(global-set-key (kbd "M-d") 'my/delete-word)
(global-set-key (kbd "M-<backspace>") 'my/backward-kill-word)

;; moving with ace-jump-mode
(require 'ace-jump-mode)
(set-face-foreground 'ace-jump-face-foreground "lime green")
(set-face-bold-p 'ace-jump-face-foreground t)
(set-face-underline-p 'ace-jump-face-foreground t)

(defun backward-symbol (arg)
  (interactive "p")
  (forward-symbol (- arg)))

(defun my/setup-symbol-moving ()
  (local-set-key (kbd "C-M-f") 'forward-symbol)
  (local-set-key (kbd "C-M-b") 'backward-symbol))

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

;; moving block
(defvar my/backward-up-list-regexp
  "[{\"(\[]")
(make-variable-buffer-local 'my/backward-up-list-regexp)

(defvar my/down-list-regexp
  "[{\"(\[]")
(make-variable-buffer-local 'my/down-list-regexp)

(defun my/backward-up-list (arg)
  (interactive "p")
  (unless (ignore-errors
            (backward-up-list arg) t)
    (re-search-backward my/backward-up-list-regexp nil t)))

(defun my/down-list (arg)
  (interactive "p")
  (unless (ignore-errors
            (down-list arg) t)
    (re-search-forward my/down-list-regexp nil t)))

(global-set-key (kbd "C-M-u") 'my/backward-up-list)
(global-set-key (kbd "C-M-d") 'my/down-list)

;; like Vim 'f'
(defun my/move-specified-char (arg)
  (interactive "p")
  (let ((regexp (char-to-string (read-char))))
    (if (and current-prefix-arg (listp current-prefix-arg))
        (re-search-backward regexp nil t)
      (forward-char 1)
      (re-search-forward regexp nil t arg)
      (backward-char 1))))

(global-set-key (kbd "C-M-r") 'my/move-specified-char)

;; Insert next line and previous line('o' and 'O')
(defun my/edit-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun my/edit-previous-line ()
  (interactive)
  (forward-line -1)
  (if (not (= (line-number-at-pos) 1))
      (end-of-line))
  (newline-and-indent))

(global-set-key [(shift return)] 'my/edit-next-line)
(global-set-key (kbd "M-o") 'my/edit-next-line)
(global-set-key (kbd "M-O") 'my/edit-previous-line)

;; autopair
(eval-after-load "autopair"
  '(progn
     (setq-default autopair-blink nil
                   autopair-blink-delay 0)))

(defvar my/autopair-enabled-modes
  '(c-mode
    c++-mode
    python-mode
    haskell-mode
    sh-mode
    js-mode
    go-mode
    coffee-mode
    cperl-mode))

(dolist (mode my/autopair-enabled-modes)
  (add-hook (intern (format "%s-hook" mode)) 'autopair-mode))

;; highlight specified words
(defun my/add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|TODO\\|XXX\\|@@@\\)\\>"
          1 '((:foreground "pink") (:weight bold)) t))))

(add-hook 'prog-mode-hook 'my/add-watchwords)

;; unwrap
(defvar my/unwrap-pair
  '(("(" . ")") ("[" . "]") ("{" . "}") ("'" . "'") ("\"" . "\"")
    ("<" . ">") ("|" . "|")))

(defsubst my/unwrap-counterpart (sign)
  (assoc-default sign my/unwrap-pair))

(defun my/unwrap-at-point (arg)
  (interactive "p")
  (save-excursion
    (when (re-search-backward "\\([(\[{'\"<]\\)" (point-min) t arg)
      (let ((start (point))
            (pair (my/unwrap-counterpart (match-string 1))))
        (forward-char 1)
        (when (re-search-forward pair nil t arg)
          (backward-char)
          (delete-char 1)
          (goto-char start)
          (delete-char 1))))))
(global-set-key (kbd "M-s") 'my/unwrap-at-point)

(defun my/zap-to-char (arg char)
  (interactive "p\ncZap to char: ")
  (with-no-warnings
    (when (char-table-p translation-table-for-input)
      (setq char (or (aref translation-table-for-input char) char))))
  (kill-region (point)
               (progn
                 (search-forward (char-to-string char) nil nil arg)
                 (backward-char 1)
                 (point))))
(global-set-key (kbd "M-z") 'my/zap-to-char)
