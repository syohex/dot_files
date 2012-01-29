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

(defun kill-global-messeage-buffer ()
  "Kill all global message buffers"
  (interactive)
  (dolist (buf (buffer-list))
    (let ((buf-name (buffer-name buf)))
      (if (and (string-match "^\\*" buf-name)
               (not (string-match "*scratch*" buf-name)))
          (kill-buffer buf)))))
