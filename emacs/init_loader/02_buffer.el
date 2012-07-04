;;;; setting about `buffer'

;; iswitchb
(iswitchb-mode)
(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match))

;; iswitchbで表示しないバッファ
(setq iswitchb-buffer-ignore
      '(
        "\\*.+"
        ))

;; auto-save
(require 'auto-save-buffers)
(run-with-idle-timer 5 t 'auto-save-buffers)

;; move other window
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; naming of same name file
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; use ibuffer instead of list-buffer
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
