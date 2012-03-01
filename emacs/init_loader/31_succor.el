;;;; succor.el for source code reading
;; (auto-install-from-url "https://raw.github.com/takaishi/succor/master/succor.el")
(require 'succor)

;; Directory in notes
(setq *succor-directory* "~/.succor/")

;; with gtags(GNU Global)
(setq succor-gtags-enable t)

;; with imenu
(setq succor-imenu-enable t)
