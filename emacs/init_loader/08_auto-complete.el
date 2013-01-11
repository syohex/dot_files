;; setting of auto-complete
(require 'popup)
(require 'fuzzy)
(require 'pos-tip)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/dot_files/emacs/ac-dict")
(global-auto-complete-mode t)
(ac-config-default)

;; other modes to be enable auto-complete
(add-to-list 'ac-modes 'git-commit-mode)
(add-to-list 'ac-modes 'markdown-mode)

(setq ac-auto-start nil)

(setq ac-use-menu-map t)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map (kbd "<tab>") 'ac-complete)

(setq ac-quick-help-delay 0.1)

;; for global minor mode
(defun my/auto-complete ()
  (interactive)
  (case major-mode
    (ruby-mode (ac-complete-rsense))
    (python-mode (jedi:complete))
    (otherwise (auto-complete))))

;; look command with auto-complete
(defun my/ac-look ()
  "`look' command with auto-completelook"
  (interactive)
  (unless (executable-find "look")
    (error "Please install `look' command"))
  (let ((word (thing-at-point 'word)))
    (unless word
      (error "not found word"))
    (let ((cmd (format "look %s" word)))
      (with-temp-buffer
        (call-process-shell-command cmd nil t)
        (split-string-and-unquote (buffer-string) "\n")))))

(defun ac-look ()
  (interactive)
  (let ((ac-menu-height 50)
        (ac-candidate-limit t))
  (auto-complete '(ac-source-look))))

(defvar ac-source-look
  '((candidates . my/ac-look)
    (requires . 2)))

(global-set-key (kbd "C-M-l") 'ac-look)
