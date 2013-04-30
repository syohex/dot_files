;;;; popwin
(require 'popwin)
(defvar popwin:special-display-config-backup popwin:special-display-config)
(setq display-buffer-function 'popwin:display-buffer)

;; basic
(push '("*Help*" :stick t :noselect t) popwin:special-display-config)

;; popwin for slime
(push '(slime-repl-mode :stick t) popwin:special-display-config)

;; man
(push '(Man-mode :stick t :height 20) popwin:special-display-config)

;; Elisp
(push '("*ielm*" :stick t) popwin:special-display-config)
(push '("*eshell pop*" :stick t) popwin:special-display-config)

;; pry
(push '(inf-ruby-mode :stick t :height 20) popwin:special-display-config)

;; python
(push '("*Python*"   :stick t) popwin:special-display-config)
(push '("*Python Help*" :stick t :height 20) popwin:special-display-config)
(push '("*jedi:doc*" :stick t :noselect t) popwin:special-display-config)

;; Haskell
(push '("*haskell*" :stick t) popwin:special-display-config)
(push '("*GHC Info*") popwin:special-display-config)

;; sgit
(push '("*sgit*" :position right :width 0.5 :stick t)
      popwin:special-display-config)

;; direx
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)

(defun my/popup-beginning-of-defun ()
  (interactive)
  (popwin:popup-buffer (current-buffer)
                       :height 0.4 :position 'bottom)
  (case major-mode
    ((c-mode c++-mode) (c-beginning-of-defun))
    (otherwise (beginning-of-defun)))
  (forward-paragraph 1))
(global-set-key (kbd "M-g M-a") 'popup-beginning-of-defun)
