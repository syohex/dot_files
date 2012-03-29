;; Common Lisp
(setq inferior-lisp-program
      (cond
       ((executable-find "ccl") "ccl")
       ((executable-find "clisp") "clisp")))

(setenv "CCL_DEFAULT_DIRECTORY" (expand-file-name "~/local/ccl"))

;; for indent
;; (auto-install-from-url "http://boinkor.net/lisp/cl-indent-patches.el")
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

;; hyperspec with anything
(setq anything-c-source-hyperspec
      `((name . "Lookup Hyperspec")
        (candidates . ,(lambda ()
                         (mapcar #'symbol-name
                                 (obarray-to-list common-lisp-hyperspec-symbols))))
        (action . (("Show Hyperspec" . hyperspec-lookup)))))

(defun anything-hyperspec ()
  (interactive)
  (anything 'anything-c-source-hyperspec (thing-at-point 'symbol)))

(defun my/lisp-mode-hook ()
  (define-key lisp-mode-map (kbd "C-c C-d C-l") 'anything-hyperspec))

(add-hook 'lisp-mode-hook 'my/lisp-mode-hook)
