;; Mac initialize setting
(if (string-equal (pwd) "Directory /")
    (cd (getenv "HOME")))
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
(setq default-input-method "MacOSX")
(global-set-key (kbd "C-o") 'toggle-input-method)

;; for ansi-term
(setq system-uses-terminfo nil)
