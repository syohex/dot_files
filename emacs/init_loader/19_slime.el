;;; sly
(custom-set-variables
 '(sly-net-coding-system 'utf-8-unix))

(with-eval-after-load 'sly
  (setq inferior-lisp-program "sbcl")
  ;;(setq sly-protocol-version 'ignore)      ;; for clojure

  (defalias 'sly-cleanup 'sly-restart-inferior-lisp)

  ;; hyperspec
  (let ((sly-libdir (concat (file-name-directory (locate-library "sly")) "lib")))
    (add-to-list 'load-path sly-libdir))

  ;; ac-sly
  (add-hook 'sly-mode-hook 'set-up-sly-ac)
  (add-hook 'sly-mrepl-mode-hook 'set-up-sly-ac)

  ;; bindings
  (define-key sly-mode-map (kbd "C-M-i") 'auto-complete)
  (define-key sly-mode-map (kbd "C-c C-d C-a") 'helm-editutil-hyperspec)
  (define-key sly-mode-map (kbd "C-c C-d C-d") 'hyperspec-lookup))

(with-eval-after-load 'sly-mrepl
  (define-key sly-mrepl-mode-map (kbd "TAB") nil)
  (define-key sly-mrepl-mode-map (kbd "C-M-i") 'auto-complete))

(with-eval-after-load 'hyperspec
  (let ((hyperspec-dir (expand-file-name (concat user-emacs-directory "elisps/HyperSpec/"))))
    (setq common-lisp-hyperspec-root (concat "file://" hyperspec-dir)
          common-lisp-hyperspec-symbol-table (concat hyperspec-dir "Data/Map_Sym.txt"))))

(dolist (hook '(lisp-mode-hook))
  (add-hook hook 'sly-mode))
