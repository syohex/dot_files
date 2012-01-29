;; Scala language setting
(add-to-list 'load-path "~/.emacs.d/scala-mode")
(require 'scala-mode-auto) ;; Please install Scala
(require 'scala-mode)

(define-key scala-mode-map (kbd "C-c S") 'scala-run-scala)
(define-key scala-mode-map (kbd "C-c C-e") 'scala-eval-definition)

(setq scala-mode-indent:step 4)

;; setting ensime
(add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
(when (require 'ensime nil t)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))
