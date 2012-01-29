;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(require 'cperl-mode)
(autoload 'cperl-mode "cperl-mode")
(add-to-list 'auto-mode-alist
         '("\\.\\(pl\\|pm\\|cgi\\|t\\|psgi\\)$" . cperl-mode))
(setq interpreter-mode-alist (append interpreter-mode-alist
                                     '(("miniperl" . cperl-mode))))

(define-key cperl-mode-map (kbd "C-c C-d") 'plcmp-cmd-show-doc)
(define-key cperl-mode-map (kbd "C-c C-a") 'plcmp-cmd-show-doc-at-point)
(define-key cperl-mode-map (kbd "C-c C-f") 'anything-project)
(define-key cperl-mode-map (kbd "C-j") 'dabbrev-expand)

(setq indent-tabs-mode nil
      cperl-indent-level 4
      cperl-continued-statement-offset 0
      cperl-close-paren-offset -4
      cperl-indent-region-fix-constructs 1
      cperl-indent-parens-as-block t)

(put 'perl-module-thing 'end-op
     (lambda ()
       (re-search-forward "\\=[a-zA-Z][a-zA-Z0-9_:]*" nil t)))
(put 'perl-module-thing 'beginning-op
     (lambda ()
       (if (re-search-backward "[^a-zA-Z0-9_:]" nil t)
           (forward-char)
         (goto-char (point-min)))))

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

;(setq cperl-auto-newline t)
(add-hook 'cperl-mode-hook
          (lambda ()
            (hs-minor-mode 1)
            (set-face-bold-p 'cperl-array-face nil)
            (set-face-background 'cperl-array-face nil)
            (set-face-bold-p 'cperl-hash-face nil)
            (set-face-foreground 'cperl-hash-face "DarkOliveGreen3")
            (set-face-italic-p 'cperl-hash-face nil)
            (set-face-background 'cperl-hash-face nil)))

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
(define-key cperl-mode-map (kbd "C-c C-t") 'perltidy-region)
(define-key cperl-mode-map (kbd "C-c C-T") 'perltidy-defun)

;; pod-mode
(require 'pod-mode)
(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))

;; set-perl5lib
(require 'set-perl5lib)

(set-face-background 'flymake-errline "red2")
(set-face-foreground 'flymake-errline "OliveDrab1")
(set-face-background 'flymake-warnline "goldenrod1")
(set-face-foreground 'flymake-warnline "black")

;; http://unknownplace.org/memo/2007/12/21#e001
(defvar flymake-perl-err-line-patterns
  '("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1))

(defconst flymake-allowed-perl-file-name-masks
  '(("\\.pl$" flymake-perl-init)
    ("\\.pm$" flymake-perl-init)
    ("\\.t$" flymake-perl-init)
    ("\\.psgi$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns
        (cons flymake-perl-err-line-patterns flymake-err-line-patterns))
  (set-perl5lib)
  (flymake-mode t))

(add-hook 'cperl-mode-hook 'flymake-perl-load)

;; move point to 'use section or package'
(defvar cperl/mib-orig-marker (make-marker))
(defun cperl/move-import-block ()
  (interactive)
  (progn
    (set-marker cperl/mib-orig-marker (point-marker))
    (if (re-search-backward "^\\(use\\|package\\)\[ \n\]+\[^;\]+;" nil t)
        (progn
          (goto-char (match-end 0))
          (next-line))
      (goto-char (point-min)))))

(defun cperl/back-to-last-marker ()
  (interactive)
  (goto-char cperl/mib-orig-marker))

(define-key cperl-mode-map (kbd "M-<up>") 'cperl/move-import-block)
(define-key cperl-mode-map (kbd "M-<down>") 'cperl/back-to-last-marker)

;; auto-complete
(add-hook 'cperl-mode-hook
          (lambda ()
            (defvar plcmp-default-lighter  " PLC")
            (require 'perl-completion)
            (perl-completion-mode t)
            (add-to-list 'ac-sources 'ac-source-perl-completion)))

;; for xs-mode
(require 'xs-mode)
(add-to-list 'auto-mode-alist '("\\.xs$" . xs-mode))

(add-hook 'xs-mode-hook
          (lambda ()
            (c-toggle-electric-state -1)
            (setq c-auto-newline nil)))

(defun xs-perldoc ()
  (interactive)
  (let* ((docs-alist '(("perlapi") ("perlxs") ("perlguts")
                 ("perlcall") ("perlclib") ("perlxstut")))
         (manual-program "perldoc")
         (input (completing-read "perldoc entry: " docs-alist)))
    (if input
        (manual-entry input)
      (error "no input"))))

(define-key xs-mode-map (kbd "C-c C-a") 'xs-perldoc)
(define-key xs-mode-map (kbd "C-c C-d") 'xs-perldoc)
