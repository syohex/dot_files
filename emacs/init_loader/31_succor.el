;;;; succor.el for source code reading
;; (install-elisp "https://raw.github.com/takaishi/succor/master/succor.el")
(require 'succor)

;; Directory in notes
(setq *succor-directory* "~/.succor/")

;; with gtags(GNU Global)
(setq succor-gtags-enable t)

;; with imenu
(setq succor-imenu-enable t)
