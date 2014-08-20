;;;; cperl-mode
(add-to-list 'auto-mode-alist
             '("\\.\\(pl\\|pm\\|cgi\\|t\\|psgi\\)\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile\\'" . cperl-mode))

(with-eval-after-load 'cperl-mode
  (cperl-set-style "PerlStyle")
  (setq cperl-auto-newline nil)

  (helm-perldoc:setup)

  ;; bindings
  (define-key cperl-mode-map "\177" nil)
  (define-key cperl-mode-map (kbd ";") nil)
  (define-key cperl-mode-map (kbd ":") nil)
  (define-key cperl-mode-map (kbd "(") nil)
  (define-key cperl-mode-map (kbd "{") nil)
  (define-key cperl-mode-map (kbd "}") nil)
  (define-key cperl-mode-map (kbd "[") nil)

  (define-key cperl-mode-map (kbd "C-c C-d") 'helm-perldoc)
  (define-key cperl-mode-map (kbd "C-c C-r") 'helm-perldoc:history)

  ;; faces
  (set-face-attribute 'cperl-array-face nil
                      :background nil :weight 'normal)
  (set-face-attribute 'cperl-hash-face nil
                      :foreground "DarkOliveGreen3" :background nil
                      :weight 'normal :italic nil))

;; for flymake
(with-eval-after-load 'flymake
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.\\(?:pl\\|pm\\|t\\|psgi\\)\\'" my/flymake-perl-init)))

(defun my/flymake-perl-root-directory ()
  (cl-loop with curdir = default-directory
           for file in '("Makefile.PL" "Build.PL" "cpanfile")
           when (locate-dominating-file curdir file)
           return (directory-file-name (expand-file-name it))))

(defun my/flymake-perl-add-topdir-option ()
  (let ((curdir (directory-file-name (file-name-directory (buffer-file-name))))
        (rootdir (my/flymake-perl-root-directory)))
    (when (and rootdir (not (string= curdir rootdir)))
      (format "-I%s" rootdir))))

(defun my/flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name)))
         (topdir (my/flymake-perl-add-topdir-option)))
    (if topdir
        `("perl" ,(list "-MProject::Libs" topdir "-wc" local-file))
      `("perl" ,(list "-MProject::Libs" "-wc" local-file)))))

(defun my/cperl-imenu-create-index ()
  (let (index)
    (save-excursion
      ;; collect subroutine
      (goto-char (point-min))
      (while (re-search-forward "^\\s-*sub\\s-+\\([^ ]+\\)" nil t)
        (push (cons (format "Function: %s" (match-string 1))
                    (match-beginning 1)) index))

      ;; collect subtest
      (goto-char (point-min))
      (let ((desc-re "^\\s-*subtest\\s-+\\(['\"]\\)\\([^\1\r\n]+\\)\\1"))
        (while (re-search-forward desc-re nil t)
          (push (cons (format "Subtest: %s" (match-string 2))
                      (match-beginning 0)) index)))
      (nreverse index))))

(defun my/cperl-mode-hook ()
  (flymake-mode t)
  (hs-minor-mode 1)

  ;; my own imenu. cperl imenu is too many information for me
  (set (make-local-variable 'imenu-create-index-function)
       'my/cperl-imenu-create-index))

(add-hook 'cperl-mode-hook 'my/cperl-mode-hook)

(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset -4)
 '(cperl-indent-subs-specially nil))

;; pod-mode
(add-to-list 'auto-mode-alist '("\\.pod\\'" . pod-mode))

;; XS
(autoload 'xs-mode "xs-mode" "Major mode for XS files" t)
(add-to-list 'auto-mode-alist '("\\.xs\\'" . xs-mode))
(with-eval-after-load "xs-mode"
  (c-toggle-electric-state -1)
  (setq c-auto-newline nil)
  (define-key xs-mode-map (kbd "C-c C-a") 'xs-perldoc)
  (define-key xs-mode-map (kbd "C-c C-d") 'xs-perldoc))

(defun xs-perldoc ()
  (interactive)
  (let* ((docs-alist '(("perlapi") ("perlxs") ("perlguts")
                 ("perlcall") ("perlclib") ("perlxstut")))
         (manual-program "perldoc")
         (input (completing-read "perldoc entry: " docs-alist)))
    (unless input
      (error "xs-perldoc: no input!!"))
    (manual-entry input)))
