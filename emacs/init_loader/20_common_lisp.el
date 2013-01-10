;; Common Lisp
(setq inferior-lisp-program
      (cond
       ((executable-find "ccl") "ccl")
       ((executable-find "clisp") "clisp")))

(setenv "CCL_DEFAULT_DIRECTORY" (expand-file-name "~/local/ccl"))

;; for indent
(when (require 'cl-indent-patches nil t)
  (setq lisp-indent-function
        (lambda (&rest args)
          (apply (if (memq major-mode '(emacs-lisp-mode lisp-interaction-mode))
                     'lisp-indent-function
                   'common-lisp-indent-function)
                 args))))

;; hyperspec document
(require 'hyperspec)
(setq common-lisp-hyperspec-root
      (concat "file://" (expand-file-name "~/doc/HyperSpec/")))
(setq common-lisp-hyperspec-symbol-table
      (expand-file-name "~/doc/HyperSpec/Data/Map_Sym.txt"))

(defun obarray-to-list (obarray)
  (let (symbols)
    (mapatoms (lambda (symb) (push symb symbols))
              obarray)
    symbols))

;; hyperspec with helm
(defvar helm-c-source-hyperspec
  `((name . "Lookup Hyperspec")
    (candidates . ,(lambda ()
                     (mapcar #'symbol-name
                             (obarray-to-list common-lisp-hyperspec-symbols))))
    (action . (("Show Hyperspec" . hyperspec-lookup))))
  "helm ")

(defun helm-hyperspec ()
  (interactive)
  (helm 'helm-c-source-hyperspec (thing-at-point 'symbol)))
