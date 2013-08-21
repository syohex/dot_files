;; setting of auto-complete
(require 'popup)
(require 'fuzzy)
;;(require 'pos-tip)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (concat user-emacs-directory "ac-dict"))
(global-auto-complete-mode t)
(ac-config-default)

;; Enable auto-complete mode other than default enable modes
(dolist (mode '(git-commit-mode
                coffee-mode
                go-mode
                markdown-mode
                fundamental-mode
                org-mode
                text-mode))
  (add-to-list 'ac-modes mode))

(setq ac-auto-start nil
      ac-use-menu-map t
      ac-quick-help-delay 1.0)

(global-set-key (kbd "C-x l") 'ac-last-quick-help)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map (kbd "<tab>") 'ac-complete)

;; for global minor mode
(defun my/auto-complete ()
  (interactive)
  (case major-mode
    (ruby-mode (ac-complete-rsense))
    (python-mode (jedi:complete))
    (otherwise
     (if auto-complete-mode
         (auto-complete)
       (call-interactively 'dabbrev-expand)))))

;; look command with auto-complete
(defun ac-look--judge-case (str)
  (let ((case-fold-search nil))
    (cond ((string-match "\\`[A-Z]\\{2\\}" str) 'upcase)
          ((string-match "\\`[A-Z]\\{1\\}" str) 'capitalize)
          (t 'identity))))

(defun ac-look-candidates ()
  (if (not (executable-find "look"))
      (message "Error: not found `look'")
    (let ((result (format "look -f %s" ac-prefix))
          (case-func (ac-look--judge-case ac-prefix)))
      (ignore-errors
        (mapcar case-func
                (split-string (shell-command-to-string result) "\n"))))))

(defun ac-look ()
  (interactive)
  (auto-complete '(ac-source-look)))

(ac-define-source look
  '((candidates . ac-look-candidates)
    (requires . 2)))

(global-set-key (kbd "C-M-l") 'ac-look)
