;; not display password in shell-mode
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)

;; emux
(autoload 'emux:term "emux" nil t)
(autoload 'emux:term-other-window "emux" nil t)
(global-set-key (kbd "C-!") 'emux:term-other-window)
(push '(term-mode :height 0.5 :stick t) popwin:special-display-config)

(defun term-toggle-mode ()
  (interactive)
  (if (term-in-char-mode)
      (term-line-mode)
    (term-char-mode)))

;; ansi-term
(defun my/term-mode-hook ()
  (define-key term-raw-map (kbd "M-x") 'nil)
  (define-key term-raw-map (kbd "C-x") 'nil)
  (define-key term-raw-map (kbd "C-g") 'nil)

  (define-key term-mode-map (kbd "C-c C-j") 'term-toggle-mode)
  (define-key term-raw-escape-map (kbd "C-j") 'term-toggle-mode)

  (define-key term-raw-map (kbd "C-c c") 'emux:term-new)
  (define-key term-raw-map (kbd "C-c ,") 'emux:term-rename)
  (define-key term-raw-map (kbd "C-c x") 'emux:term-kill)

  (set-face-background 'emux:tab-bar-face "SpringGreen1"))

(add-hook 'term-mode-hook 'my/term-mode-hook)

;; color setting
(setq ansi-term-color-vector
      [unspecified "black" "red1" "lime green" "yellow2"
                   "DeepSkyBlue3" "magenta2" "cyan2" "white"])
