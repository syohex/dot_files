;; setting for ruby
(add-to-list 'auto-mode-alist '("\\.\\(?:rb\\|gemspec\\|ru\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\(?:Rakefile\\|Gemfile\\|Guardfil\\)\\'" . ruby-mode))

(custom-set-variables
 '(ruby-deep-indent-paren nil)
 '(ruby-insert-encoding-magic-comment nil))

(eval-after-load "ruby-mode"
  '(progn
     ;; rbenv
     ;;(global-rbenv-mode t) ;; I think it may not be needed

     ;; binding
     (define-key ruby-mode-map (kbd "|") 'my/ruby-insert-bar)
     (define-key ruby-mode-map (kbd "C-M-a") 'my/ruby-beginning-of-defun)
     (define-key ruby-mode-map (kbd "C-M-e") 'my/ruby-end-of-defun)

     (define-key ruby-mode-map (kbd "C-c C-a") 'ruby-beginning-of-block)
     (define-key ruby-mode-map (kbd "C-c C-e") 'ruby-end-of-block)
     (define-key ruby-mode-map (kbd "C-c ?") 'my/ruby-search-doc)

     (defface my/ruby-mode-special-literal
       '((t (:foreground "orchid1")))
       "Face of Ruby's regexp"
       :group 'ruby-mode)

     (font-lock-add-keywords
      'ruby-mode '(("\\(?:^\\|[[ \t\n<+(,=]\\)\\(%[xrqQwW]?\\)\\({[^\n\\\\]*\\(?:\\\\.[^\n\\\\]*\\)*}\\)\\([ixms]+\\)?"
                    (1 'my/ruby-mode-special-literal t)
                    (2 font-lock-string-face t)
                    (3 'my/ruby-mode-special-literal t t))
                   ("\\(?:^\\|[[ \t\n<+(,=]\\)\\(%[xrqQwW]?\\)\\(([^\n\\\\]*\\(?:\\\\.[^\n\\\\]*\\)*)\\)\\([ixms]+\\)?"
                    (1 'my/ruby-mode-special-literal t)
                    (2 font-lock-string-face t)
                    (3 'my/ruby-mode-special-literal t t))))

     ;; autopair
     (define-key ruby-mode-map "(" nil)
     (define-key ruby-mode-map ")" nil)
     (define-key ruby-mode-map "{" nil)
     (define-key ruby-mode-map "}" nil)
     (define-key ruby-mode-map "[" nil)
     (define-key ruby-mode-map "]" nil)
     (define-key ruby-mode-map "\"" nil)
     (define-key ruby-mode-map "'" nil)

;;     ;; smartparens
;;     (require 'smartparens-ruby)
;;     (set-face-attribute 'sp-show-pair-match-face nil
;;                         :background "grey20" :foreground "green"
;;                         :weight 'semi-bold)

     ;; yari
     (define-key ruby-mode-map (kbd "C-c C-d") 'yari-helm)))

(defun my/ruby-mode-hook ()
  (setq flycheck-checker 'ruby-rubocop)

  ;; robe
  (robe-mode +1)
  (add-to-list 'ac-sources 'ac-source-robe)

  ;; smartparen
  (show-smartparens-mode +1)

  ;; auto insert `end'
  (ruby-end-mode 1))

(add-hook 'ruby-mode-hook 'my/ruby-mode-hook)

(defvar yari-helm-source-ri-pages
  '((name . "RI documentation")
    (candidates . (lambda () (yari-ruby-obarray)))
    (action  ("Show with Yari" . yari))
    (candidate-number-limit . 300)
    (requires-pattern . 2)
    "Source for completing RI documentation."))

(defun yari-helm (&optional rehash)
  (interactive (list current-prefix-arg))
  (when current-prefix-arg (yari-ruby-obarray rehash))
  (helm :sources 'yari-helm-source-ri-pages :buffer "*yari*"))

;; insert "|"
(defun my/ruby-insert-bar ()
  (interactive)
  (if (looking-back "\\(do\\|{\\) +")
      (progn
        (insert "||")
        (backward-char 1))
    (insert "|")))

;; Ruby's move defun
(defun my/ruby-beginning-of-defun (&optional arg)
  (interactive "p")
  (and (re-search-backward (concat "^\\s-+\\(" ruby-block-beg-re "\\)\\_>")
                           nil 'move)
       (progn (back-to-indentation) t)))

(defun my/ruby-end-of-defun (&optional arg)
  (interactive "p")
  (and (re-search-forward (concat "^\\s-+\\(" ruby-block-end-re "\\)\\($\\|\\b[^_]\\)")
                          nil 'move (or arg 1))
       (progn (beginning-of-line) t))
  (forward-line 1)
  (back-to-indentation))

(defun my/ruby-search-doc (searched)
  (interactive
   (list (read-string "Searchd Doc: ")))
  (let ((cmd (concat "ri -T -f ansi " (shell-quote-argument searched))))
   (with-current-buffer (get-buffer-create "*ri-doc*")
     (view-mode -1)
     (erase-buffer)
     (unless (zerop (call-process-shell-command cmd nil t))
       (error "Failed: '%s'" cmd))
     (goto-char (point-min))
     (ansi-color-apply-on-region (point-min) (point-max))
     (view-mode +1)
     (pop-to-buffer (current-buffer)))))

;;;; rbenv
;;(eval-after-load "rbenv"
;;  '(progn
;;     (set-face-attribute 'rbenv-active-ruby-face nil
;;                         :foreground "yellow")))
