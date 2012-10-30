;; setting of auto-complete
(require 'popup)
(require 'fuzzy)
(require 'pos-tip)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/dot_files/emacs/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

(setq ac-auto-start nil)

(setq ac-use-menu-map t)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map "\t" 'ac-complete)

(setq ac-quick-help-delay 0.1)

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
