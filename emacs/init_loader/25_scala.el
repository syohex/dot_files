;;;; Scala language setting
;;(require 'scala-mode-auto)

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
