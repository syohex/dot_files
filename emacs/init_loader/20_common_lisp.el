;; Common Lisp
(setq inferior-lisp-program
      (cond
       ((executable-find "ccl") "ccl")
       ((executable-find "clisp") "clisp")))

;; hyperspec document
(eval-after-load "lisp-mode"
  '(progn
     (require 'hyperspec)
     (let ((hyperspec-dir (concat user-emacs-directory "elisps/HyperSpec/")))
      (setq common-lisp-hyperspec-root (concat "file://" hyperspec-dir))
      (setq common-lisp-hyperspec-symbol-table
            (concat hyperspec-dir "Data/Map_Sym.txt")))

     ;; indent
     (require 'cl-indent-patches)
     (setq lisp-indent-function
           (lambda (&rest args)
             (apply (if (memq major-mode '(emacs-lisp-mode lisp-interaction-mode))
                        'lisp-indent-function
                      'common-lisp-indent-function)
                    args)))))

(defun my/obarray-to-list (obarray)
  (let (symbols)
    (mapatoms (lambda (symb) (push symb symbols))
              obarray)
    symbols))

;; hyperspec with helm
(defvar helm-hyperspec-source
  `((name . "Lookup Hyperspec")
    (candidates . ,(lambda ()
                     (mapcar #'symbol-name
                             (my/obarray-to-list common-lisp-hyperspec-symbols))))
    (action . (("Show Hyperspec" . hyperspec-lookup))))
  "helm ")

(defun helm-hyperspec ()
  (interactive)
  (helm 'helm-hyperspec-source (thing-at-point 'symbol)))
