;; setting for emacs-lisp
(find-function-setup-keys)

;;;; eldoc
(require 'eldoc-extension)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")
(set-face-attribute 'eldoc-highlight-function-argument nil
                    :underline t :foreground "green"
                    :weight 'bold)

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
     (define-key ,keymap (kbd "C-M-i") 'auto-complete)
     (define-key ,keymap (kbd "C-c C-z") 'ielm-other-window)))

(my/set-elisp-map emacs-lisp-mode-map)
(my/set-elisp-map lisp-interaction-mode-map)
