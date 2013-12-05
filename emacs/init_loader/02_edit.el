;;;; editing operations
;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "C-x M-%") 'anzu-query-replace-at-cursor)
(global-set-key (kbd "C-x %") 'anzu-query-replace-at-cursor-thing)

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

;; for word delete instead of kill-word and backward-kill-word
(defun my/delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun my/backward-kill-word (arg)
  (interactive "p")
  (let ((from (save-excursion
                (forward-word -1)
                (point)))
        (limit (save-excursion
                 (back-to-indentation)
                 (point))))
    (cond ((bolp) (backward-kill-word arg))
          (t
           (delete-region (max from limit) (point))))))

(global-set-key (kbd "M-d") 'my/delete-word)
(global-set-key (kbd "M-<backspace>") 'my/backward-kill-word)

;; moving with ace-jump-mode
(eval-after-load "ace-jump-mode"
  '(progn
     (setq ace-jump-mode-case-fold nil)
     (set-face-foreground 'ace-jump-face-foreground "lime green")
     (set-face-bold-p 'ace-jump-face-foreground t
                      (set-face-underline-p 'ace-jump-face-foreground t))))

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

;; electrict-mode
(custom-set-variables
 '(electric-indent-mode nil))

;; autopair
(custom-set-variables
 '(autopair-blink nil)
 '(autopair-blink-delay 0))

(defvar my/autopair-enabled-modes
  '(c-mode
    c++-mode
    java-mode
    python-mode
    ruby-mode
    erlang-mode
    prolog-mode
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

;; editutil
(dolist (func '(editutil-edit-next-line
                editutil-edit-previous-line
                editutil-unwrap-at-point
                editutil-replace-wrapped-string
                editutil-edit-next-line-no-indent
                editutil-edit-next-line-same-column
                editutil-zap-to-char
                editutil-next-symbol
                editutil-previous-symbol
                editutil-forward-char
                editutil-backward-char
                editutil-move-line-up
                editutil-move-line-down))
  (autoload func "editutil" nil t))

(global-set-key [(control shift up)] 'editutil-move-line-up)
(global-set-key [(control shift down)] 'editutil-move-line-down)

(global-set-key (kbd "C-M-s") 'editutil-forward-char)
(global-set-key (kbd "C-M-r") 'editutil-backward-char)

(global-set-key (kbd "M-o") 'editutil-edit-next-line)
(global-set-key (kbd "M-O") 'editutil-edit-previous-line)

(global-set-key (kbd "M-s") 'editutil-unwrap-at-point)
(global-set-key (kbd "M-r") 'editutil-replace-wrapped-string)
(global-set-key (kbd "M-z") 'editutil-zap-to-char)

(global-set-key (kbd "M-n") 'editutil-next-symbol)
(global-set-key (kbd "M-p") 'editutil-previous-symbol)
