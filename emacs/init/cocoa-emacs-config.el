;; Mac specified setting(Meta key, input method, terminfo)
(setq-default ns-command-modifier 'meta
              ;;ns-alternate-modifier 'meta
              ns-use-native-fullscreen nil ;; Don't use system fullscreen
              system-uses-terminfo nil)

;; for yosemite
(fringe-mode -1)

(unless (featurep 'mozc)
  (setq default-input-method "MacOSX"))

;; key config
(global-set-key (kbd "C-x ?") 'dash-at-point)

;; font setting
(set-face-attribute 'default nil
                    :family "monaco"
                    :height 140)
(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0208
 '("Hiragino Maru Gothic Pro" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0212
 '("Hiragino Maru Gothic Pro" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'katakana-jisx0201
 '("Hiragino Maru Gothic Pro" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'mule-unicode-0100-24ff
 '("monaco" . "iso10646-1"))
(set-fontset-font
 t 'symbol
 (font-spec :family "Apple Color Emoji") nil 'prepend)

(setq-default face-font-rescale-alist
              '(("^-apple-hiragino.*" . 1.2)
                (".*osaka-bold.*" . 1.2)
                (".*osaka-medium.*" . 1.2)
                (".*courier-bold-.*-mac-roman" . 1.0)
                (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                (".*monaco-bold-.*-mac-roman" . 0.9)
                ("-cdac$" . 1.3)))

(set-face-bold-p 'show-paren-match-face nil)
