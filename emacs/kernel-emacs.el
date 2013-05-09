;; encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)

(require 'cl)

;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; Add load path of emacs lisps
(add-to-list 'load-path "~/.emacs.d/elisps")

;; for editing config files
(require 'generic-x)

;; restore construction of windows
(require 'winner)
(winner-mode t)

(require 'thingopt)
(define-thing-commands)

;; for GC
(setq gc-cons-threshold (* gc-cons-threshold 10))

;; echo stroke
(setq echo-keystrokes 0.1)

;; large file
(setq large-file-warning-threshold (* 25 1024 1024))

;; isearch
(defun isearch-yank-symbol ()
  (interactive)
  (isearch-yank-internal (lambda () (forward-symbol 1) (point))))
(define-key isearch-mode-map (kbd "C-M-w") 'isearch-yank-symbol)

;; saveplace
(savehist-mode 1)
(load "saveplace")
(setq-default save-place t)

;; Use regexp version as Default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)

;; my key mapping
(global-set-key (kbd "M-C-o") 'other-window)
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "C-M-j") 'dabbrev-expand)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "C-M-s") 'helm-occur)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-c") 'helm-M-x)
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "M-g M-f") 'ffap)

(setq dabbrev-case-fold-search nil)

;; info for japanese
(auto-compression-mode t)

;; Coloring
(global-font-lock-mode t)

;; not highlight region
(transient-mark-mode nil)

;; indicate last line
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)

;; not create backup file
(setq backup-inhibited t)

;; not create auto save file
(setq delete-auto-save-files t)

;; Disable menu bar
(menu-bar-mode -1)

;; show paren
(show-paren-mode 1)
(setq show-paren-delay 0
      show-paren-style 'expression)

(defun kill-following-spaces ()
  (interactive)
  (let ((orig-point (point)))
    (save-excursion
      (skip-chars-forward " \t")
      (delete-region orig-point (point)))))
(global-set-key (kbd "M-k") 'kill-following-spaces)

;; not beep
(setq ring-bell-function (lambda()))

;; not display start message
(setq inhibit-startup-message t)

;; display line infomation
(line-number-mode 1)
(column-number-mode 1)

(defalias 'exit 'save-buffers-kill-emacs)

;; ignore upper or lower
(setq read-file-name-completion-ignore-case t)

;; Delete key
(global-set-key [delete] 'delete-char)

;; backspace
(when (not window-system)
  (normal-erase-is-backspace-mode 0))

(require 'autopair)
(setq-default autopair-blink-delay 0)

;; C coding style
(defun backward-symbol (arg)
  (interactive "p")
  (forward-symbol (- arg)))

(defun my/set-symbol-moving ()
  (local-set-key (kbd "C-M-f") 'forward-symbol)
  (local-set-key (kbd "C-M-b") 'backward-symbol))

(defun my/c-up-block ()
  (interactive)
  (search-backward "{" nil t))

(defun my/c-mode-hook ()
  (c-set-style "k&r")
  (hs-minor-mode 1)
  (my/set-symbol-moving)
  (autopair-mode)
  (define-key c-mode-map (kbd "C-c o") 'ff-find-other-file)
  (c-toggle-electric-state -1)
  (if window-system
      (setq c-basic-offset 4)
    (setq c-basic-offset 8))
  (helm-gtags-mode))

(add-hook 'c-mode-hook 'my/c-mode-hook)

;; C++ coding style
(add-hook 'c++-mode-hook 'my/c-mode-hook)

;; asm-mode
(add-hook 'asm-mode-hook
          '(lambda ()
             (helm-gtags-mode)))

;; ibuffer
(defalias 'list-buffers 'ibuffer)

;; mark 'D'(delete) for matching buffer
(require 'ibuffer)
(defun ibuffer-menu-grep-delete (str)
  (interactive "sregexp: ")
  (save-excursion
    (goto-char (point-min))
    (forward-line 2)
    (while (re-search-forward str nil t)
      (save-excursion
        (ibuffer-mark-for-delete nil))
      (end-of-line))))
(define-key ibuffer-mode-map "R" 'ibuffer-menu-grep-delete)

;; undo tree
(setq undo-no-redo t
      undo-limit 600000
      undo-strong-limit 900000)

;;;; dired
(require 'dired)
;; Not create new buffer, if you chenge directory in dired
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
;; display directories by first
(when (executable-find "gls")
  (setq insert-directory-program "gls"))
(load-library "ls-lisp")
(setq ls-lisp-dirs-first t)
;; recursive copy, remove
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; dired-x
(load "dired-x")

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; helm
(require 'helm-config)
(require 'helm-gtags)
(require 'helm-ag)

(define-key helm-map (kbd "C-q") 'helm-execute-persistent-action)

(setq helm-c-ack-insert-at-point 'symbol)

(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0)
(setq helm-candidate-number-limit 500)

(require 'helm-descbinds)
(helm-descbinds-install)

;; gtags
(add-hook 'helm-gtags-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
	     (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
	     (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
	     (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))

;; ack
(setq helm-c-ack-insert-at-point 'symbol)

;; helm in dired
(setq-default split-width-threshold 0)

(define-key helm-map (kbd "C-p") 'helm-previous-line)
(define-key helm-map (kbd "C-n") 'helm-next-line)

;; helm-show-kill-ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; apropos with helm and man
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-h m") 'helm-man-woman)

;; helm faces
(when (not window-system)
  (require 'helm-files)
  (set-face-background 'helm-selection "pink")
  (set-face-foreground 'helm-selection "black")
  (set-face-foreground 'helm-ff-file "white")
  (set-face-bold-p 'helm-ff-file nil)
  (set-face-foreground 'helm-ff-directory "cyan")
  (set-face-background 'helm-ff-directory nil)

  (set-face-foreground 'highlight nil)
  (set-face-background 'highlight "green")
  (set-face-underline-p 'highlight t))

;; naming of same name file
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; recentf-ext
(setq recentf-max-saved-items 1000
      recentf-save-file "~/.recentf-kernel")
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(run-at-time t 600 'recentf-save-list)
(setq recentf-exclude '("/auto-install/" ".recentf" "/repos/" "/elpa/"
                        "\\.mime-example" "\\.ido.last"))

;; for virsion control system
(global-auto-revert-mode 1)
(setq auto-revert-interval 10)
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; disable vc-mode
(setq vc-handled-backends '())

;; which-func
(require 'which-func)
(setq which-func-modes (append which-func-modes '(cperl-mode)))
(set-face-foreground 'which-func "chocolate4")
(set-face-bold-p 'which-func t)
(which-func-mode t)

;; view-mode
(setq view-read-only t)

;; for regexp color
(set-face-foreground 'font-lock-regexp-grouping-backslash "#ff1493")
(set-face-foreground 'font-lock-regexp-grouping-construct "#ff8c00")

;; move physical line
(setq line-move-visual nil)

;; popwin
(require 'popwin)
(defvar popwin:special-display-config-backup popwin:special-display-config)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      (append '(("*Apropos*") ("*sdic*") ("*Faces*") ("*Colors*"))
              popwin:special-display-config))

;; use popwin
(push '(Man-mode :stick t :height 20) popwin:special-display-config)
(push '("*sgit*" :width 0.5 :position right :stick t) popwin:special-display-config)

(defun my/popup-beginning-of-defun ()
  (interactive)
  (popwin:popup-buffer (current-buffer)
                       :height 0.4 :position 'bottom)
  (case major-mode
    ((c-mode c++-mode) (c-beginning-of-defun))
    (otherwise (beginning-of-defun)))
  (forward-paragraph))
(global-set-key (kbd "M-g M-a") 'my/popup-beginning-of-defun)

;; savekill
(require 'savekill)

;; flyspell
(require 'flyspell)
(define-key flyspell-mode-map (kbd "M-.") 'flyspell-auto-correct-word)
(define-key flyspell-mode-map (kbd "M-,") 'flyspell-goto-next-error)

;; fixed line position after scrollup, scrolldown
(defadvice scroll-up (around scroll-up-relative activate)
  "Scroll up relatively without move of cursor."
  (let ((orig-line (count-lines (window-start) (point))))
    ad-do-it
    (move-to-window-line orig-line)))

(defadvice scroll-down (around scroll-down-relative activate)
  "Scroll down relatively without move of cursor."
  (let ((orig-line (count-lines (window-start) (point))))
    ad-do-it
    (move-to-window-line orig-line)))

;; for symboliclink
(setq-default find-file-visit-truename t)

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

(global-set-key (kbd "M-e") 'forward-word)

(defun my/move-to-char ()
  (interactive)
  (let ((regexp (char-to-string (read-char))))
   (cond (current-prefix-arg
	  (re-search-backward regexp nil t))
	 (t
	  (forward-char 1)
	  (re-search-forward regexp nil t)
	  (backward-char 1)))))
(global-set-key (kbd "C-M-r") 'my/move-to-char)

;; (makunbound 'overriding-minor-mode-map)
(define-minor-mode overriding-minor-mode
  "Most superior minir mode"
  t  ;; default is enable
  "" ;; Not display mode-line
  `((,(kbd "M-a") . backward-paragraph)
    (,(kbd "M-e") . forward-paragraph)))

(defvar my/alt-q-map (make-sparse-keymap)
  "My original keymap binded to M-q.")
(defalias 'my/alt-q-prefix my/alt-q-map)
(define-key overriding-minor-mode-map (kbd "M-q") 'my/alt-q-prefix)

(defun add-hyper-char-to-ace-jump-char-mode (c)
  (define-key my/alt-q-map
    (read-kbd-macro (string c))
    `(lambda ()
       (interactive)
       (setq ace-jump-query-char ,c)
       (setq ace-jump-current-mode 'ace-jump-char-mode)
       (ace-jump-do (concat "\\b"
                            (regexp-quote (make-string 1 ,c)))))))

(loop for c from ?0 to ?9 do (add-hyper-char-to-ace-jump-char-mode c))
(loop for c from ?A to ?Z do (add-hyper-char-to-ace-jump-char-mode c))
(loop for c from ?a to ?z do (add-hyper-char-to-ace-jump-char-mode c))

(defun non-elscreen-current-directory ()
  (let* ((bufsinfo (cadr (cadr (current-frame-configuration))))
         (bufname-list (assoc-default 'buffer-list bufsinfo)))
    (loop for buf in bufname-list
	  for file = (or (buffer-file-name buf)
			 (with-current-buffer buf
			   (when (eq major-mode 'dired-mode)
			     dired-directory)))
	  when file
	  return (file-name-directory it))))

;; ace-jump-mode
(require 'ace-jump-mode)

(set-face-foreground 'ace-jump-face-foreground "green")
(set-face-bold-p 'ace-jump-face-foreground t)
(set-face-underline-p 'ace-jump-face-foreground t)
(set-face-foreground 'ace-jump-face-background "grey40")

;; switch next/previous buffer
(global-set-key (kbd "M-9") 'bs-cycle-next)
(global-set-key (kbd "M-0") 'bs-cycle-previous)

(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))
(global-set-key (kbd "C-x %") 'goto-match-paren)

;; scroll bar
(require 'yascroll)
(global-yascroll-bar-mode t)
(setq yascroll:disabled-modes
      '(completing-list-mode))

;; smartrep
(require 'smartrep)

;; like Vim's "o"
(defun edit-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun edit-prev-line ()
  (interactive)
  (forward-line -1)
  (if (not (= (line-number-at-pos) 1))
      (end-of-line))
  (newline-and-indent))

(global-set-key (kbd "M-o") 'edit-next-line)
(global-set-key (kbd "M-O") 'edit-prev-line)

;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My original keymap binded to C-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)
(define-key my/ctrl-q-map (kbd "|") 'winner-undo)
(define-key my/ctrl-q-map (kbd "C-b") 'helm-bookmarks)
(define-key my/ctrl-q-map (kbd "l") 'mark-line)

(defun my/find-file-other-window (file)
  (interactive
   (list (read-file-name "Display file: ")))
  (let ((buf (find-file-noselect file)))
    (cond ((one-window-p)
           (find-file-other-window file))
          (t
           (other-window 1)
           (set-window-buffer (selected-window) buf)))))
(define-key my/ctrl-q-map (kbd "C-f") 'my/find-file-other-window)

(defun my/revert-buffer ()
  (interactive)
  (revert-buffer nil t))
(define-key my/ctrl-q-map (kbd "r") 'my/revert-buffer)

(defun my/delete-to-specified-character ()
  (interactive)
  (let ((curpoint (point))
        (regexp (read-char "Delete to: ")))
    (skip-chars-forward (concat "^" (char-to-string regexp)))
    (delete-region curpoint (point))))

(define-key my/ctrl-q-map (kbd "d") 'my/delete-to-specified-character)

(defun swap-buffers ()
  (interactive)
  (when (one-window-p)
    (error "This frame is not splitted!!"))
  (let ((curwin (selected-window))
        (curbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer curwin (window-buffer))
    (set-window-buffer (selected-window) curbuf)))
(define-key my/ctrl-q-map (kbd "b") 'swap-buffers)

(defun my/delete-line ()
  (interactive)
  (delete-region (line-beginning-position) (line-end-position)))
(define-key my/ctrl-q-map (kbd "k") 'my/delete-line)

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

;; goto-chg
(require 'goto-chg)
(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

(defun my/duplicate-line ()
  (interactive)
  (let ((line (thing-at-point 'line)))
    (save-excursion
      (forward-line 1)
      (insert line))))
(smartrep-define-key
    global-map "M-g" '(("c" . 'my/duplicate-line)))

;; sgit
(require 'sgit)
(global-set-key (kbd "C-x v d") 'sgit:diff)
(global-set-key (kbd "C-x v s") 'sgit:status)
(global-set-key (kbd "C-x v l") 'sgit:log)

;; magit
(global-set-key (kbd "M-g M-g") 'magit-status)

;; auto-complete
(require 'popup)
(require 'fuzzy)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)

;; other modes to be enable auto-complete
(add-to-list 'ac-modes 'git-commit-mode)

(setq ac-auto-start nil)
(setq ac-use-menu-map t)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map (kbd "<tab>") 'ac-complete)

(setq ac-quick-help-delay 0.5)

;; look command with auto-complete
(defun my/ac-look ()
  "`look' command with auto-completelook"
  (interactive)
  (unless (executable-find "look")
    (error "Please install `look' command"))
  (let ((cmd (format "look %s" ac-prefix)))
    (with-temp-buffer
      (call-process-shell-command cmd nil t)
      (split-string-and-unquote (buffer-string) "\n"))))

(defun ac-look ()
  (interactive)
  (let ((ac-menu-height 50)
        (ac-candidate-limit t))
    (auto-complete '(ac-source-look))))

(defvar ac-source-look
  '((candidates . my/ac-look)
    (requires . 2)))

(global-set-key (kbd "C-M-i") 'auto-complete)
(global-set-key (kbd "C-M-l") 'ac-look)

;; my point push utilities
(defun my/push-marker ()
  (interactive)
  (push-mark))
(global-set-key (kbd "C-q p") 'my/push-marker)

;; for diff
(require 'diff-mode)

;; eshell
(eval-after-load "em-prompt"
  '(progn
     (set-face-attribute 'eshell-prompt nil
                         :foreground "yellow")))

(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)))

(defvar eshell-pop-buffer "*eshell-pop*")
(defvar eshell-prev-buffer nil)

(defun eshell-pop ()
  (interactive)
  (setq eshell-prev-buffer (current-buffer))
  (unless (get-buffer eshell-pop-buffer)
    (save-window-excursion
      (pop-to-buffer (get-buffer-create eshell-pop-buffer))
      (eshell-mode)))
  (popwin:popup-buffer (get-buffer eshell-pop-buffer)
                       :height 20 :stick t))
(global-set-key (kbd "M-g M-s") 'eshell-pop)

(defun eshell/cde ()
  (let* ((file-name (buffer-file-name eshell-prev-buffer))
         (dir (or (and file-name (file-name-directory file-name))
                  (and (eq major-mode 'dired-mode) dired-directory)
                  (with-current-buffer eshell-prev-buffer
                    default-directory))))
    (eshell/cd dir)))

(defun eshell/cdp ()
  (let* ((cmd "git rev-parse --show-toplevel")
         (dir (with-temp-buffer
                (unless (call-process-shell-command cmd nil t)
                  (error "Here is not Git Repository"))
                (goto-char (point-min))
                (buffer-substring-no-properties
                 (point) (line-end-position)))))
    (eshell/cd dir)))

;; ido
(ido-mode 'file)
;;; Disable override some keybinds(eg. find-file)
(setcdr (cdar (cddr ido-minor-mode-map-entry)) nil)
(defun my/ido-find-file ()
  (interactive)
  (let ((ido-mode t)
        (ido-max-prospects 8))
    (if current-prefix-arg
        (ido-find-file-other-window)
      (ido-find-file-in-dir default-directory))))
(global-set-key (kbd "C-x C-p") 'my/ido-find-file)

(set-face-attribute 'ido-first-match nil
                    :foreground "orange" :weight 'semi-bold)
(set-face-attribute 'ido-only-match nil
                    :foreground "orange" :weight 'semi-bold)
(set-face-attribute 'ido-subdir nil
                    :foreground "cyan" :weight 'semi-bold)

(require 'import-popwin)
(global-set-key (kbd "M-g M-i") 'import-popwin)

(progn
  (set-face-attribute 'show-paren-match nil
		      :background nil :foreground nil
		      :underline t :weight 'bold)

  (set-face-attribute 'diff-added nil
		      :background nil :foreground "green"
		      :weight 'normal)
  (set-face-attribute 'diff-removed nil
		      :background nil :foreground "red"
		      :weight 'normal)

  (set-face-attribute 'diff-refine-change nil
		      :background nil :foreground "yellow"
		      :weight 'normal)

  (set-face-attribute 'diff-file-header nil
		      :foreground "white"
		      :background nil :weight 'extra-bold)

  (set-face-attribute 'diff-function nil
		      :foreground "cyan"
		      :background nil
		      :underline nil)

  (set-face-attribute 'diff-header nil
		      :background nil
		      :underline nil)

  (set-face-attribute 'diff-hunk-header nil
		      :foreground "yellow"
		      :background nil
		      :weight 'bold
		      :underline t))
