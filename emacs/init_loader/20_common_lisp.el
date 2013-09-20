;; Common Lisp
(setq inferior-lisp-program
      (cond
       ((executable-find "sbcl") "sbcl")
       ((executable-find "clisp") "clisp")))

;; hyperspec document
(eval-after-load "lisp-mode"
  '(progn
     (require 'hyperspec)
     (let ((hyperspec-dir (expand-file-name
                           (concat user-emacs-directory "elisps/HyperSpec/"))))
       (setq common-lisp-hyperspec-root (concat "file://" hyperspec-dir))
       (setq common-lisp-hyperspec-symbol-table
             (concat hyperspec-dir "Data/Map_Sym.txt")))))

(defun my/obarray-to-list (obarray)
  (let (symbols)
    (mapatoms (lambda (symb) (push symb symbols))
              obarray)
    symbols))

;; hyperspec with helm
(defvar helm-hyperspec-source
  `((name . "Lookup Hyperspec")
    (candidates . ,(lambda ()
                     (mapcar 'symbol-name
                             (my/obarray-to-list common-lisp-hyperspec-symbols))))
    (action . (("Show Hyperspec" . hyperspec-lookup))))
  "helm ")

(defun helm-hyperspec ()
  (interactive)
  (helm :sources '(helm-hyperspec-source)
        :default (thing-at-point 'symbol)
        :buffer (get-buffer-create "*helm HyperSpec*")))
