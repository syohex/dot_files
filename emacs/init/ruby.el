;; setting for ruby
(defun helm-robe-completing-read (prompt choices &optional predicate require-match)
  (let ((collection (mapcar (lambda (c) (if (listp c) (car c) c)) choices)))
    (helm-comp-read prompt collection :test predicate :must-match require-match)))

(custom-set-variables
 '(ruby-deep-indent-paren nil)
 '(ruby-insert-encoding-magic-comment nil)
 '(robe-completing-read-func 'helm-robe-completing-read)
 '(robe-highlight-capf-candidates nil))

(with-eval-after-load 'ruby-mode
  (add-hook 'ruby-mode-hook 'my/ruby-mode-hook)
  ;; rbenv
  ;;(global-rbenv-mode t) ;; I think it may not be needed

  ;; binding
  (define-key ruby-mode-map (kbd "|") 'my/ruby-insert-bar)
  (define-key ruby-mode-map (kbd "C-M-a") 'my/ruby-beginning-of-defun)
  (define-key ruby-mode-map (kbd "C-M-e") 'my/ruby-end-of-defun)

  (define-key ruby-mode-map (kbd "C-c C-a") 'ruby-beginning-of-block)
  (define-key ruby-mode-map (kbd "C-c C-e") 'ruby-end-of-block)
  (define-key ruby-mode-map (kbd "C-c ?") 'robe-doc)

  ;; disable default bindings
  (dolist (key '("(" ")" "{" "}" "[" "]" "\"" "'"))
    (define-key ruby-mode-map key nil)))

(defun my/ruby-mode-hook ()
  (setq flycheck-checker 'ruby-rubocop)

  ;; robe
  (robe-mode +1)
  (add-to-list 'ac-sources 'ac-source-robe)
  ;;(add-to-list 'company-backends 'company-robe)

  ;; auto insert `end'
  (ruby-end-mode +1))

;; insert "|"
(defun my/ruby-insert-bar ()
  (interactive)
  (if (looking-back "\\(?:do\\s-+\\|{\\)")
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

(defun my/ruby-test ()
  (interactive)
  (let ((root (locate-dominating-file default-directory "Rakefile")))
    (unless root
      (error "Here is not Ruby source tree"))
    (let* ((curfile (file-relative-name (buffer-file-name) root))
           (rspec-p (string-suffix-p "_spec.rb" curfile)))
      (let* ((default-directory root)
             (has-bundle (file-exists-p ".bundle"))
             (command (if has-bundle "bundle exec " ""))
             (compilation-scroll-output t))
        (if rspec-p
            (compile (concat command "rspec " curfile))
          (compile (concat command "ruby -Ilib:test " curfile)))))))
