;; not display password in shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; emux
(require 'emux)
(global-set-key (kbd "C-!") 'emux:term)
;; avoid abnormal exit
(defvar emux:term-last-dir nil)
(defadvice emux:term (before emux:term-save-last-directory activate)
  (setq emux:term-last-dir default-directory))

;; ansi-term
(defun my/term-mode-hook
  (define-key term-raw-map (kbd "M-x") 'nil)
  (define-key term-raw-map (kbd "C-z") 'nil)
  (define-key term-raw-map (kbd "C-q") 'nil)

  (define-key term-raw-map (kbd "C-c c") 'emux:term-new)
  (define-key term-raw-map (kbd "C-c n") 'emux:term-next)
  (define-key term-raw-map (kbd "C-c p") 'emux:term-previous))

(add-hook 'term-mode-hook 'my/term-mode-hook)

;; color setting
(setq ansi-term-color-vector
      [unspecified "black" "red1" "lime green" "yellow2"
                   "DeepSkyBlue3" "magenta2" "cyan2" "white"])

;; shell-pop
(require 'shell-pop)

(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-window-height 50)
(shell-pop-set-internal-mode-shell shell-file-name)
(shell-pop-set-window-position "bottom")
(global-set-key (kbd "C-x C-z") 'shell-pop)
