;;; slime
;;(require 'slime-autoloads)

(custom-set-variables
 '(slime-net-coding-system 'utf-8-unix))

(eval-after-load "slime"
  '(progn
     (setq inferior-lisp-program "ccl")

     ;; SLIME REPL
     (slime-setup '(slime-repl slime-fancy slime-banner slime-presentations))

     (setq slime-autodoc-delay 0.5)

     ;; for clojure
     (setq slime-protocol-version 'ignore)

     ;; face
     (set-face-foreground 'slime-repl-inputed-output-face "pink1")

     (defalias 'slime-cleanup 'slime-restart-inferior-lisp)

     ;; hyperspec
     (add-to-list 'load-path (concat (file-name-directory (locate-library "slime")) "lib"))
     (require 'hyperspec)
     (let ((hyperspec-dir (expand-file-name
                           (concat user-emacs-directory "elisps/HyperSpec/"))))
       (setq common-lisp-hyperspec-root (concat "file://" hyperspec-dir)
             common-lisp-hyperspec-symbol-table (concat hyperspec-dir "Data/Map_Sym.txt")))

      ;;;; ac-slime
     (add-hook 'slime-mode-hook 'set-up-slime-ac)
     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

     ;; bindings
     (define-key slime-mode-map (kbd "C-M-i") 'auto-complete)
     (define-key slime-mode-map (kbd "C-c C-d C-a") 'helm-hyperspec)
     (define-key slime-mode-map (kbd "C-c C-d C-d") 'common-lisp-hyperspec)))

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
    (action . (("Show Hyperspec" . hyperspec-lookup)))))

(defun helm-hyperspec ()
  (interactive)
  (helm :sources '(helm-hyperspec-source)
        :default (thing-at-point 'symbol)
        :buffer (get-buffer-create "*Helm HyperSpec*")))

(eval-after-load "slime-repl"
  '(progn
     (define-key slime-repl-mode-map (kbd "TAB") nil)
     (define-key slime-repl-mode-map (kbd "C-M-i") 'auto-complete)))

(dolist (hook '(lisp-mode-hook))
  (add-hook hook 'slime-mode))
