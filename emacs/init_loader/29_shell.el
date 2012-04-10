;; not display password in shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; emux
(require 'emux)
(global-set-key (kbd "C-!") 'emux:term)
(set-face-background 'emux:tab-bar-face "SpringGreen1")

;; ansi-term
(defun my/term-mode-hook ()
  (define-key term-raw-map (kbd "M-x") 'nil)
  (define-key term-raw-map (kbd "M-0") 'nil)
  (define-key term-raw-map (kbd "C-z") 'nil)
  (define-key term-raw-map (kbd "C-q") 'nil)

  (define-key term-raw-map (kbd "C-c c") 'emux:term-new)
  (define-key term-raw-map (kbd "C-c ,") 'emux:term-rename)
  (define-key term-raw-map (kbd "C-c x") 'emux:term-kill))

(add-hook 'term-mode-hook 'my/term-mode-hook)

;; color setting
(setq ansi-term-color-vector
      [unspecified "black" "red1" "lime green" "yellow2"
                   "DeepSkyBlue3" "magenta2" "cyan2" "white"])
