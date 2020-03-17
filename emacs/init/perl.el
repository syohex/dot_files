;;;; cperl-mode
(add-to-list 'auto-mode-alist
             '("\\.\\(pl\\|pm\\|cgi\\|t\\|psgi\\)\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("cpanfile\\'" . cperl-mode))
(defalias 'perl-mode 'cperl-mode)

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

;;  (define-key cperl-mode-map (kbd "C-c C-d") 'helm-perldoc)
;;  (define-key cperl-mode-map (kbd "C-c C-r") 'helm-perldoc:history)
)

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
  (hs-minor-mode 1)

  ;; my own imenu. cperl imenu is too many information for me
  (setq imenu-create-index-function 'my/cperl-imenu-create-index))

(add-hook 'cperl-mode-hook 'my/cperl-mode-hook)

(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset -4)
 '(cperl-indent-subs-specially nil))
