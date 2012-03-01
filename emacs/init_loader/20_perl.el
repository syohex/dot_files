;;;; cperl-mode
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/perl-completion.el")
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist
         '("\\.\\(pl\\|pm\\|cgi\\|t\\|psgi\\)$" . cperl-mode))

(eval-after-load "cperl-mode"
  '(progn
     (cperl-set-style "PerlStyle")

     ;; bindings
     (define-key cperl-mode-map (kbd "(") nil)
     (define-key cperl-mode-map (kbd "{") nil)
     (define-key cperl-mode-map (kbd "[") nil)
     (define-key cperl-mode-map (kbd "M-<up>") 'cperl/move-import-block)
     (define-key cperl-mode-map (kbd "M-<down>") 'cperl/back-to-last-marker)

     ;; faces
     (set-face-bold-p 'cperl-array-face nil)
     (set-face-background 'cperl-array-face nil)
     (set-face-bold-p 'cperl-hash-face nil)
     (set-face-foreground 'cperl-hash-face "DarkOliveGreen3")
     (set-face-italic-p 'cperl-hash-face nil)
     (set-face-background 'cperl-hash-face nil)))

(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset -4))

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

;; pod-mode
(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))

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

;; completion
(add-hook 'cperl-mode-hook
          (lambda ()
            (defvar plcmp-default-lighter  " PLC")
            (perl-completion-mode t)
            (flymake-mode t)
            (hs-minor-mode 1)
            (when (boundp 'auto-complete-mode)
              (defvar ac-source-my-perl-completion
                '((candidates . plcmp-ac-make-cands)))
              (add-to-list 'ac-sources 'ac-source-my-perl-completion))))

;; perl completion
(autoload 'perl-completion-mode "perl-completion" nil t)
(eval-after-load "perl-completion"
  '(progn
     (defadvice flymake-start-syntax-check-process (around flymake-start-syntax-check-lib-path activate)
       (plcmp-with-set-perl5-lib ad-do-it))
     (defalias 'perldoc 'plcmp-cmd-show-doc)
     (define-key cperl-mode-map (kbd "C-c C-d") 'plcmp-cmd-show-doc)
     (define-key cperl-mode-map (kbd "C-c C-a") 'plcmp-cmd-show-doc-at-point)
     (define-key plcmp-mode-map (kbd "M-C-o") 'plcmp-cmd-smart-complete)))

;; XS
;; (auto-install-from-url "http://www.emacswiki.org/emacs/download/xs-mode.el")
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
