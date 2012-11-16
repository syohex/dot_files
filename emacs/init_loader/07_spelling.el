;; configuration of spell check
(require 'ispell)
(setq-default ispell-program-name "aspell")
(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))

;; flyspell
(autoload 'flyspell-mode "flyspell" "spell checking at runtime")
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mode-map (kbd "M-n") 'flyspell-goto-next-error)
     (define-key flyspell-mode-map (kbd "M-.") 'flyspell-auto-correct-word)))
