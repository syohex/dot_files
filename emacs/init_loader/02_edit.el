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

(defun my/yank (arg)
  (interactive "P")
  (setq yank-window-start (window-start))
  (setq this-command t)
  (push-mark (point))
  (let ((str (current-kill 0)))
    (dotimes (i (or arg 1))
      (insert-for-yank str)))
  (when (eq this-command t)
    (setq this-command 'yank))
  nil)
(global-set-key (kbd "C-y") 'my/yank)

;; Vim's 'f', 'F'
(defvar my/last-find-char nil)

(defsubst my/save-last-char (arg char)
  (setq my/last-find-char (list :count arg :char char)))

(defun my/forward-to-char (arg char)
  (interactive "p\ncForward to char: ")
  (my/save-last-char arg char)
  (forward-char 1)
  (let ((case-fold-search nil))
    (search-forward (char-to-string char) nil nil arg))
  (backward-char 1))

(defun my/backward-to-char (arg char)
  (interactive "p\ncBackward to char: ")
  (my/save-last-char arg char)
  (let ((case-fold-search nil))
    (search-backward (char-to-string char) nil nil arg)))

(defun my/repeat-find-char ()
  (interactive)
  (when (null my/last-find-char)
    (error "Last find char is not found"))
  (let ((count (plist-get my/last-find-char :count))
        (char (plist-get my/last-find-char :char)))
    (my/forward-to-char count char)))

(defun my/repeat-find-char-reverse ()
  (interactive)
  (when (null my/last-find-char)
    (error "Last find char is not found"))
  (let ((count (plist-get my/last-find-char :count))
        (char (plist-get my/last-find-char :char)))
    (my/backward-to-char count char)))

(global-set-key (kbd "C-M-s") 'my/forward-to-char)
(global-set-key (kbd "C-M-r") 'my/backward-to-char)

(smartrep-define-key
    global-map  "C-x" '((">" . 'my/repeat-find-char)
                        ("<" . 'my/repeat-find-char-reverse)))

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
(eval-after-load "ace-jump-mode"
  '(progn
     (set-face-foreground 'ace-jump-face-foreground "lime green")
     (set-face-bold-p 'ace-jump-face-foreground t
                      (set-face-underline-p 'ace-jump-face-foreground t))))

(defun backward-symbol (arg)
  (interactive "p")
  (forward-symbol (- arg)))

(defun my/setup-symbol-moving ()
  (local-set-key (kbd "C-M-f") 'forward-symbol)
  (local-set-key (kbd "C-M-b") 'backward-symbol))

(put 'set-goal-column 'disabled nil)

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
  "[{\"(\[`']")
(make-variable-buffer-local 'my/backward-up-list-regexp)

(defvar my/down-list-regexp
  "[{\"(\[`']")
(make-variable-buffer-local 'my/down-list-regexp)

(defvar my/forward-list-regexp
  "[\]})\"'`]")
(make-variable-buffer-local 'my/forward-list-regexp)

(defvar my/backward-list-regexp
  "[{\"(\[`']")
(make-variable-buffer-local 'my/backward-list-regexp)

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

(defun my/forward-list (arg)
  (interactive "p")
  (unless (ignore-errors
            (forward-list arg) t)
    (re-search-forward my/forward-list-regexp nil t)))

(defun my/backward-list (arg)
  (interactive "p")
  (unless (ignore-errors
            (backward-list arg) t)
    (re-search-backward my/backward-list-regexp nil t)))

(global-set-key (kbd "C-M-u") 'my/backward-up-list)
(global-set-key (kbd "C-M-d") 'my/down-list)
(global-set-key (kbd "C-M-n") 'my/forward-list)
(global-set-key (kbd "C-M-p") 'my/backward-list)

;; Insert next line and previous line('o' and 'O')
(defun my/edit-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun my/edit-next-line-no-indent ()
  (interactive)
  (end-of-line)
  (newline))

(defun my/edit-next-line-same-column ()
  (interactive)
  (let ((col (save-excursion
               (back-to-indentation)
               (current-column))))
    (end-of-line)
    (newline)
    (move-to-column col t)))

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
    java-mode
    python-mode
    haskell-mode
    inferior-haskell-mode
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
    ("<" . ">") ("|" . "|") ("`" . "`")))

(defsubst my/unwrap-counterpart (sign)
  (assoc-default sign my/unwrap-pair))

(defun my/unwrap-at-point (arg)
  (interactive "p")
  (save-excursion
    (when (re-search-backward "\\([(\[{'\"`|<]\\)" (point-min) t arg)
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
  (delete-region (point)
                 (progn
                   (when (>= arg 0)
                     (forward-char 1))
                   (search-forward (char-to-string char) nil nil arg)
                   (if (>= arg 0)
                       (backward-char 1)
                     (forward-char 1))
                   (point))))
(global-set-key (kbd "M-z") 'my/zap-to-char)
