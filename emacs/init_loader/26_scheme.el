;; setting for scheme
(autoload 'scheme-mode "scheme" nil t)

(eval-after-load "scheme"
  '(progn
     (setq scheme-program-name "gosh")
     (require 'cmuscheme)
     (push '("*scheme*" :stick t) popwin:special-display-config)
     (define-key scheme-mode-map (kbd "C-c S") 'scheme-other-window)
     (define-key global-map (kbd "C-c C-d") 'gauche-info-index)))

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(defun gauche-info-index (topic)
  (interactive
   (list (read-string
	  (concat "Gauche help topic : ")
          (current-word))))
  (switch-to-buffer-other-window (get-buffer-create "*info*"))
  (info "/usr/share/info/gauche-refe.info.gz")
  (Info-index topic))

;; not insert unneeded space for scheme-mode
(defvar my-paredit-paren-prefix-pat-gauche
  (mapconcat
   #'identity
   '(
     "#[suf]\\(8\\|16\\|32\\|64\\)"     ; SRFI-4
     "#[0-9]+="                         ; SRFI-38
     "(\\^"                             ; (^(x y) ...)
     "#\\?="                            ; debug-print
     "#vu8"                             ; R6RS bytevector
     )
   "\\|"))

(defun paredit-space-for-delimiter-p-gauche (endp delimiter)
  (or endp
      (if (= (char-syntax delimiter) ?\()
          (not (looking-back my-paredit-paren-prefix-pat-gauche))
        t)))

(defun my/scheme-mode-hook ()
  (set (make-variable-buffer-local
        'paredit-space-for-delimiter-predicates)
       (list #'paredit-space-for-delimiter-p-gauche)))

(add-hook 'scheme-mode-hook 'my/scheme-mode-hook)
