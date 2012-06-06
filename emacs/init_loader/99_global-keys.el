;;;; global key setting

;; my key mapping
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "M-<return>") 'newline-and-indent)
(global-set-key (kbd "C-x C-a") 'anything-filelist+)
(global-set-key (kbd "C-x C-w") 'anything-resume)

;;; Ctrl-z Prefix
(defvar my/ctrl-z-map (make-sparse-keymap)
  "My original keymap binded to C-z")
(unless window-system
  (define-key global-map (kbd "C-z") my/ctrl-z-map))

(global-set-key (kbd "C-z b") 'anything-bookmarks)
(global-set-key (kbd "C-z ,") 'elscreen-screen-nickname)

;; for git
(global-set-key (kbd "C-z d") 'sgit:diff)
(global-set-key (kbd "C-z l") 'sgit:log)
(global-set-key (kbd "C-z s") 'sgit:status)
(global-set-key (kbd "C-z g") 'anything-git-grep)

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

;;; switch last-buffer
(defun switch-to-last-buffer ()
  (interactive)
  (loop for buf in (cdr (buffer-list))
        when (and (not (string-match "^\s*\\*" (buffer-name buf)))
                  (and (buffer-file-name buf)
                       (not (file-directory-p (buffer-file-name buf)))))
        return (switch-to-buffer buf)))

(global-set-key (kbd "M-0") 'switch-to-last-buffer)

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

(make-file-ring '("~/.emacs.d/notes.org" my/daily-file "~/.emacs.d/zanken.org"))
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
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "@") 'bm-toggle)
(define-key my/ctrl-q-map (kbd "<backspace>") 'delete-region)

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

;; for scroll other window
(smartrep-define-key
    global-map "C-q" '(("n" . (scroll-other-window 1))
                       ("p" . (scroll-other-window -1))
                       ("N" . 'scroll-other-window)
                       ("P" . (scroll-other-window '-))
                       ("a" . (beginning-of-buffer-other-window 0))
                       ("e" . (end-of-buffer-other-window 0))))

;; for move paragraph
(smartrep-define-key
    global-map "C-q" '(("[" . (backward-paragraph))
                       ("]" . (forward-paragraph))))

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

;; Open directory
(defvar my/commonly-directories-alist
  '(("auto-install" . "~/.emacs.d/auto-install")
    (".emacs.d"     . "~/.emacs.d/")
    ("junk"         . "~/junk")
    ("program"      . "~/program")))

(defun my/open-commonly-directory ()
  (interactive)
  (let* ((key (completing-read "Select: " my/commonly-directories-alist))
         (dir (assoc-default key my/commonly-directories-alist)))
    (unless (file-exists-p dir)
      (error "'%s' is not existed"))
    (find-file dir)))

(global-set-key (kbd "<f10>") 'my/open-commonly-directory)
