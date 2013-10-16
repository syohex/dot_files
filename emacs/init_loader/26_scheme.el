;; setting for scheme
(eval-after-load "scheme"
  '(progn
     (require 'quack)
     (require 'scheme-complete)
     (require 'cmuscheme)
     (setq scheme-program-name "gosh"
           quack-default-program "gosh")
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
  (let ((info-file (loop for file in '("/usr/share/info/gauche-refe.info.gz"
                                       "/usr/local/share/info/gauche-refe.info.gz")
                         when (file-exists-p file)
                         return file)))
    (info info-file)
    (Info-index topic)))

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
  ;; buffer local variables
  (set (make-variable-buffer-local 'eldoc-documentation-function)
       'scheme-get-current-symbol-info)
  (set (make-variable-buffer-local 'paredit-space-for-delimiter-predicates)
       (list 'paredit-space-for-delimiter-p-gauche))
  (setq lisp-indent-function 'scheme-smart-indent-function))

(add-hook 'scheme-mode-hook 'my/scheme-mode-hook)
