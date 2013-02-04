;;;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist
         '("\\.\\(pl\\|pm\\|cgi\\|t\\|psgi\\)$" . cperl-mode))

(eval-after-load "cperl-mode"
  '(progn
     (cperl-set-style "PerlStyle")
     (setq cperl-auto-newline nil)

     ;; bindings
     (define-key cperl-mode-map (kbd "(") nil)
     (define-key cperl-mode-map (kbd "{") nil)
     (define-key cperl-mode-map (kbd "[") nil)
     (define-key cperl-mode-map (kbd "C-c C-d") 'helm-perldoc)

     ;; faces
     (set-face-bold-p 'cperl-array-face nil)
     (set-face-background 'cperl-array-face nil)
     (set-face-bold-p 'cperl-hash-face nil)
     (set-face-foreground 'cperl-hash-face "DarkOliveGreen3")
     (set-face-italic-p 'cperl-hash-face nil)
     (set-face-background 'cperl-hash-face nil)))

;; for flymake
(add-to-list 'flymake-allowed-file-name-masks
             '("\\(\\.pl\\|\\.pm\\|\\.t\\|\\.psgi\\)$" flymake-perl-init))

(defun flymake-perl-add-topdir-option ()
  (let ((curdir (directory-file-name (file-name-directory (buffer-file-name)))))
    (with-temp-buffer
      (let ((ret (call-process-shell-command "git rev-parse --show-toplevel" nil t)))
        (cond ((zerop ret)
               (goto-char (point-min))
               (let ((topdir (buffer-substring-no-properties (point) (line-end-position))))
                 (unless (string= topdir curdir)
                   (format "-I%s" topdir))))
              (t nil))))))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name)))
         (topdir (flymake-perl-add-topdir-option)))
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

(autoload 'helm-perldoc:setup "helm-perldoc")

(defun my/cperl-mode-hook ()
  (flymake-mode t)
  (my/setup-symbol-moving)
  (hs-minor-mode 1)

  (run-with-idle-timer 1 nil 'helm-perldoc:setup)

  ;; my own imenu. cperl imenu is too many information for me
  (set (make-local-variable 'imenu-create-index-function)
       'my/cperl-imenu-create-index))

(add-hook 'cperl-mode-hook 'my/cperl-mode-hook)

(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset -4)
 '(cperl-indent-subs-specially nil))

;; pod-mode
(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))

;; XS
(autoload 'xs-mode "xs-mode" "Major mode for XS files" t)
(add-to-list 'auto-mode-alist '("\\.xs$" . xs-mode))
(eval-after-load "xs-mode"
  '(progn
     (c-toggle-electric-state -1)
     (setq c-auto-newline nil)
     (define-key xs-mode-map (kbd "C-c C-a") 'xs-perldoc)
     (define-key xs-mode-map (kbd "C-c C-d") 'xs-perldoc)))

(defun xs-perldoc ()
  (interactive)
  (let* ((docs-alist '(("perlapi") ("perlxs") ("perlguts")
                 ("perlcall") ("perlclib") ("perlxstut")))
         (manual-program "perldoc")
         (input (completing-read "perldoc entry: " docs-alist)))
    (unless input
      (error "xs-perldoc: no input!!"))
    (manual-entry input)))

;; perltidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
