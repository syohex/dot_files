;; Mac specified setting(Meta key, input method, terminfo)
(setq-default ns-command-modifier 'meta
              ;;ns-alternate-modifier 'meta
              ns-use-native-fullscreen nil ;; Don't use system fullscreen
              system-uses-terminfo nil)

;; warning for perl
(setenv "LANG" "ja_JP.UTF-8")

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

(defun my/org-clock-done-hook ()
  (do-applescript
   "display notification \"Timer Expired. Please break\" with title \"Org Timer\" "))

(defun my/org-clock-cancel-hook ()
  (do-applescript
   "display notification \"Timer Canceled\" with title \"Org Timer\" "))

;; notifications.el cannot be available on MacOSX
(add-hook 'org-timer-done-hook #'my/org-clock-done-hook)
(add-hook 'org-timer-cancel-hook #'my/org-clock-cancel-hook)

(set-face-bold 'show-paren-match nil)

;; evil
(custom-set-variables
 '(evil-move-cursor-back nil)
 '(evil-search-module 'evil-search))

(define-key my/ctrl-q-map (kbd "e") 'evil-mode)
