;; Java language

(defun my/java-mode-hook ()
  (c-toggle-electric-state -1))

(add-hook 'java-mode-hook 'my/java-mode-hook)
