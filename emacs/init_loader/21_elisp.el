;; setting for emacs-lisp
(find-function-setup-keys)

;;;; eldoc & slimenav
(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook 'turn-on-eldoc-mode)
  (add-hook hook 'elisp-slime-nav-mode))

(eval-after-load "eldoc"
  '(progn
     (setq eldoc-idle-delay 0.2)
     (set-face-attribute 'eldoc-highlight-function-argument nil
                         :underline t :foreground "green"
                         :weight 'bold)))

;; for regexp color
(set-face-foreground 'font-lock-regexp-grouping-backslash "#ff1493")
(set-face-foreground 'font-lock-regexp-grouping-construct "#ff8c00")

;; ielm
(defun ielm-other-window ()
  "Run ielm on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*ielm*"))
  (call-interactively 'ielm))

;; Setting keymap for emacs-lisp-mode and lisp-interaction-mode
(defmacro my/set-elisp-map (keymap)
  `(progn
     (define-key ,keymap (kbd "C-c C-z") 'ielm-other-window)))

(my/set-elisp-map emacs-lisp-mode-map)
(my/set-elisp-map lisp-interaction-mode-map)
