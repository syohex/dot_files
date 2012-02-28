;;;; Scala language setting
;; Download scala firstly http://www.scala-lang.org/
(add-to-list 'load-path "~/.emacs.d/scala-mode")

;;;; Ensime -- Enhanced Scala Interaction Mode
;; https://github.com/aemoncannon/ensime
;; (shell-command "git clone https://github.com/aemoncannon/ensime.git ~/.emacs.d/ensime")
(add-to-list 'load-path "~/.emacs.d/ensime/elisp/")

(require 'scala-mode-auto)

(eval-after-load "scala-mode"
  '(progn
     ;;  (scala-electric-mode)
     (setq scala-mode-indent:step 4)

     (define-key scala-mode-map (kbd "C-c S") 'scala-run-scala)
     (define-key scala-mode-map (kbd "C-c C-e") 'scala-eval-definition)

     ;;
     (setq imenu-generic-expression
           '(("var" "\\(var +\\)\\([^(): ]+\\)" 2)
             ("val" "\\(val +\\)\\([^(): ]+\\)" 2)
             ("override def" "^[ \\t]*\\(override\\) +\\(def +\\)\\([^(): ]+\\)" 3)
             ("implicit def" "^[ \\t]*\\(implicit\\) +\\(def +\\)\\([^(): ]+\\)" 3)
             ("def" "^[ \\t]*\\(def +\\)\\([^(): ]+\\)" 2)
             ("trait" "\\(trait +\\)\\([^(): ]+\\)" 2)
             ("class" "^[ \\t]*\\(class +\\)\\([^(): ]+\\)" 2)
             ("case class" "^[ \\t]*\\(case class +\\)\\([^(): ]+\\)" 2)
             ("object" "\\(object +\\)\\([^(): ]+\\)" 2)))))

(autoload 'scala-mode "ensime")
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
