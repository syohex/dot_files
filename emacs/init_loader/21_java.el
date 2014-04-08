;; Java language

(defun my/java-mode-hook ()
  (setq indent-tabs-mode t c-basic-offset 8)
  (c-toggle-electric-state -1))

(add-hook 'java-mode-hook 'my/java-mode-hook)
