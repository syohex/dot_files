;;;; Paredit
;; (auto-install-from-url "http://mumble.net/~campbell/emacs/paredit.el")
(require 'paredit)

(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'inferior-scheme-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(add-hook 'inferior-clojure-mode-hook 'enable-paredit-mode)

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

(add-hook 'scheme-mode-hook
          #'(lambda ()
              (set (make-variable-buffer-local
                    'paredit-space-for-delimiter-predicates)
                   (list #'paredit-space-for-delimiter-p-gauche))))
