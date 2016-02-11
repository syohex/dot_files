;; setting for scheme
(custom-set-variables
 '(scheme-program-name "gosh"))

(with-eval-after-load "scheme"
  (require 'cmuscheme)
  (push '("*scheme*" :stick t) popwin:special-display-config)
  (define-key scheme-mode-map (kbd "C-c C-z") 'run-scheme)
  (define-key scheme-mode-map (kbd "C-c C-d") 'my/gauche-info-index))

(defun my/gauche-info-index (topic)
  (interactive
   (list (read-string
	  (concat "Gauche help topic : ")
          (or (current-word) ""))))
  (switch-to-buffer-other-window (get-buffer-create "*info*"))
  (let ((info-file "/usr/share/info/gauche-refe.info.gz"))
    (info info-file)
    (Info-index topic)))
