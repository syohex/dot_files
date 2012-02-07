;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-j") 'dabbrev-expand)
(global-set-key (kbd "M-<return>") 'newline-and-indent)
(global-set-key (kbd "C-M-<backspace>") 'kill-whole-line)
(global-set-key (kbd "C-S-y") 'kill-whole-line)

;;; Ctrl-z Prefix
(global-set-key (kbd "C-x C-a") 'anything-filelist+)
(global-set-key (kbd "C-x C-w") 'anything-resume)

;; for git
(global-set-key (kbd "C-z d") 'sgit:diff)
(global-set-key (kbd "C-z l") 'sgit:log)
(global-set-key (kbd "C-z s") 'sgit:status)
(global-set-key (kbd "C-z g") 'anything-git-grep)

;; for anything-project
(global-set-key (kbd "C-z C-f") 'anything-project)
(global-set-key (kbd "C-z C-g") 'anything-project-grep)

(setq my/anything-c-source-buffer+
      '((name . "anything-buffer")
        (candidates . (lambda ()
                        (mapcar 'buffer-name
                                (remove-if (lambda (b)
                                             (string-match "^\s*\\*" (buffer-name b)))
                                           (buffer-list)))))
        (type . buffer)))

(defun my/anything-buffers+ ()
  (interactive)
  (anything-other-buffer '(my/anything-c-source-buffer+) "*anything-buffer*"))
(global-set-key (kbd "C-x b") 'my/anything-buffers+)

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
(global-set-key (kbd "C-x %") 'goto-match-paren)

;; Moving per symbol
(global-set-key (kbd "M-F") 'forward-symbol)
(global-set-key (kbd "M-B") (lambda (arg)
                              (interactive "p")
                              (forward-symbol (- arg))))

;; for word delete instead of kill-word and backward-kill-word
(defun delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  (interactive "p")
  (delete-word (- arg)))

(global-set-key (kbd "M-d") 'delete-word)
(global-set-key [C-backspace] 'backward-delete-word)
(global-set-key (kbd "M-DEL") 'backward-delete-word)

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

;; document
(defmacro major-mode-eql (mode)
  `(eql major-mode ,mode))

(defun my/man ()
  (interactive)
  (let* ((manual-program
         (cond
          ((or (major-mode-eql 'cperl-mode) (major-mode-eql 'perl-mode)) "perldoc")
          ((or (major-mode-eql  'python-mode) (major-mode-eql 'py-mode)) "pydoc")
          ((major-mode-eql 'ruby-mode) "ri")
          (t "man")))
        (prompt (format "%s entry: " manual-program))
        (input (read-string prompt)))
    (if (not (string= manual-program "man"))
        (manual-entry input)
      (man input))))

(global-set-key (kbd "<f1>") 'my/man)

;;; switch last-buffer
(defvar last-buffer-saved nil)
(defvar last-buffer-exclude-name-regexp
  (rx (or "*Completions*" "*Org Export/Publishing Help*"
          (regexp "^ "))))
(defun record-last-buffer ()
  (when (and (one-window-p)
             (not (eq (window-buffer) (car last-buffer-saved)))
             (not (string-match last-buffer-exclude-name-regexp
                                (buffer-name (window-buffer)))))
    (setq last-buffer-saved
          (cons (window-buffer) (car last-buffer-saved)))))
(add-hook 'window-configuration-change-hook 'record-last-buffer)
(defun switch-to-last-buffer ()
  (interactive)
  (condition-case nil
      (switch-to-buffer (cdr last-buffer-saved))
    (error (switch-to-buffer (other-buffer)))))

(defun switch-to-last-buffer-or-other-window ()
  (interactive)
  (if (one-window-p t)
      (switch-to-last-buffer)
    (other-window 1)))
(global-set-key (kbd "M-0") 'switch-to-last-buffer-or-other-window)

;; open ring file
(defvar file-ring nil)
(defun make-file-ring (files)
  (setq file-ring (copy-sequence files))
  (setf (cdr (last file-ring)) file-ring))
(defun my/open-file-ring ()
  (interactive)
  (let ((file (car file-ring)))
    (if (functionp file)
        (find-file (funcall file))
      (find-file file)))
  (setq file-ring (cdr file-ring)))

(defun my/daily-file ()
  (interactive)
  (let* ((memodir (expand-file-name "~/memo/daily"))
         (daily-path (concat memodir "/" (format-time-string "%Y/%m"))))
    (unless (file-directory-p daily-path)
      (make-directory daily-path t))
    (let ((daily-file (concat daily-path "/" (format-time-string "%d.org"))))
      (unless (file-exists-p daily-file)
        (with-temp-file daily-file
          (insert (format-time-string "%Y年 %m月 %d日(%a)"))))
      daily-file)))

(make-file-ring '("~/.emacs.d/notes.org" my/daily-file "~/.emacs.d/book.org"))
(global-set-key (kbd "<f12>") #'my/open-file-ring)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)
(require 'col-highlight)
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-f") 'ffap)
(define-key my/ctrl-q-map (kbd "t") 'text-translator)
(define-key my/ctrl-q-map (kbd "l") 'align)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "\\") 'my/indent-region)
(define-key my/ctrl-q-map (kbd "@") 'bm-toggle)
(define-key my/ctrl-q-map (kbd "<backspace>") 'delete-region)

(defun my/indent-region ()
  (interactive)
  (let ((cur (point)))
   (save-excursion
     (call-interactively 'goto-match-paren)
     (indent-region cur (point)))))

;; window-resizer
(defun my/window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (let ((last-command-char (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))

(define-key my/ctrl-q-map (kbd "C-r") 'my/window-resizer)
(define-key my/ctrl-q-map (kbd "<right>") 'windmove-right)
(define-key my/ctrl-q-map (kbd "<left>") 'windmove-left)
(define-key my/ctrl-q-map (kbd "<down>") 'windmove-down)
(define-key my/ctrl-q-map (kbd "<up>") 'windmove-up)

;; for scroll other window
(smartrep-define-key
    global-map "C-q" '(("n" . (scroll-other-window 1))
                       ("p" . (scroll-other-window -1))
                       ("N" . 'scroll-other-window)
                       ("P" . (scroll-other-window '-))
                       ("a" . (beginning-of-buffer-other-window 0))
                       ("e" . (end-of-buffer-other-window 0))))

;; for bm-next, bm-previous
(smartrep-define-key
    global-map "C-q" '((">" . (bm-next))
                       ("<" . (bm-previous))))

;; repeat yank. Because C-y can't accept `C-u Number' prefix
(defun repeat-yank (num)
  (interactive "NRepeat Count > ")
  (dotimes (i num)
    (yank)
    (insert "\n")))
(define-key my/ctrl-q-map (kbd "y") 'repeat-yank)
(global-set-key (kbd "M-g y") 'repeat-yank)

;;;; hitahint
;; jaunte
(require 'jaunte)
(define-key my/ctrl-q-map (kbd "j") 'jaunte)
(setq jaunte-global-hint-unit 'whitespace)

;; cycle buffer
(require 'cycle-buffer)
(global-set-key (kbd "M-o") 'cycle-buffer)
(global-set-key (kbd "M-O") 'cycle-buffer-backward)

(setq cycle-buffer-filter
      (cons '(not (string-match "^*" (buffer-name))) cycle-buffer-filter))
