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
     (define-key cperl-mode-map (kbd "C-c C-i") 'cperl-insert-use-statement)
     (define-key cperl-mode-map (kbd "C-c C-d") 'cperl-perldoc)

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
    (nreverse index)))

(defun my/cperl-mode-hook ()
  (flymake-mode t)
  (my/wrap-region-as-autopair)
  (my/setup-symbol-moving)
  (hs-minor-mode 1)

  ;; my own imenu. cperl imenu is too many information for me
  (set (make-local-variable 'imenu-create-index-function)
       'my/cperl-imenu-create-index))

(add-hook 'cperl-mode-hook 'my/cperl-mode-hook)

(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset -4)
 '(cperl-indent-subs-specially nil))

;; insert 'use Module' which is at cursor.
(defun cperl-insert-use-statement ()
  "use statement auto-insertion."
  (interactive)
  (let ((module-name (cperl-word-at-point))
        (insert-point (cperl-detect-insert-point)))
    (save-excursion
      (let ((use-statement (concat "\nuse " module-name ";")))
        (if (not (search-backward use-statement nil t))
            (progn
              (goto-char insert-point)
              (insert use-statement))
          (error "'%s' is already imported" module-name))))))

(defun cperl-detect-insert-point ()
  (save-excursion
    (if (re-search-backward "use .+;" 1 t)
        (match-end 0)
      (progn
        (string-match "^$" (buffer-string))
        (match-end 0)))))

;; pod-mode
(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))

;; XS
(autoload 'xs-mode "xs-mode" "Major mode for XS files" t)
(add-to-list 'auto-mode-alist '("\\.xs$" . xs-mode))
(eval-after-load "xs-mode"
  '(progn
     (lambda ()
       (c-toggle-electric-state -1)
       (setq c-auto-newline nil)
       (define-key xs-mode-map (kbd "C-c C-a") 'xs-perldoc)
       (define-key xs-mode-map (kbd "C-c C-d") 'xs-perldoc))))

(defun xs-perldoc ()
  (interactive)
  (let* ((docs-alist '(("perlapi") ("perlxs") ("perlguts")
                 ("perlcall") ("perlclib") ("perlxstut")))
         (manual-program "perldoc")
         (input (completing-read "perldoc entry: " docs-alist)))
    (if input
        (manual-entry input)
      (error "no input"))))

;; Perl utility functions
;; exec 'perldoc -m'
(defun perldoc-m ()
  (interactive)
  (let ((module (thing-at-point 'perl-module-thing))
        (pop-up-windows t)
        (cperl-mode-hook nil))
    (when (string= module "")
      (setq module (read-string "Module Name: ")))
    (let ((result (substring (shell-command-to-string
                              (concat "perldoc -m " module)) 0 -1))
          (buffer (get-buffer-create (concat "*Perl " module "*")))
          (pop-or-set-flag (string-match "*Perl " (buffer-name))))
      (if (string-match "No module found for" result)
          (message "%s" result)
        (progn
          (with-current-buffer buffer
            (toggle-read-only -1)
            (erase-buffer)
            (insert result)
            (goto-char (point-min))
            (cperl-mode)
            (toggle-read-only 1))
          (if pop-or-set-flag
              (switch-to-buffer buffer)
            (display-buffer buffer)))))))

;; perltidy
(defun perltidy-region ()
   "Run perltidy on the current region."
   (interactive)
   (save-excursion
     (shell-command-on-region (point) (mark) "perltidy -q" nil t)))

(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))
