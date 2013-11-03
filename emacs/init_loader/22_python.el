;; python-setting

;; ipython setting
(when (memq system-type '(gnu/linux))
  (custom-set-variables
   '(python-shell-interpreter "ipython")
   '(python-shell-interpreter-args "")
   '(python-shell-prompt-regexp "In \\[[0-9]+\\]: ")
   '(python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: ")
   '(python-shell-completion-setup-code "from IPython.core.completerlib import module_completion")
   '(python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n")
   '(python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")))

(autoload 'helm-pydoc "helm-pydoc" nil t)

(eval-after-load "python"
  '(progn
     ;; binding
     (define-key python-mode-map (kbd "C-c C-d") 'helm-pydoc)))

;; jedi
(custom-set-variables
 '(jedi:tooltip-method nil))
(eval-after-load "jedi"
  '(progn
     ;; binding
     (define-key python-mode-map (kbd "C-c C-h") 'jedi:show-doc)
     (define-key python-mode-map (kbd "C-c C-l") 'jedi:get-in-function-call)

     ;; show-doc
     (set-face-attribute 'jedi:highlight-function-argument nil
                         :foreground "green")))

(defun my/python-mode-hook ()
  (setq python-indent 4)
  (jedi:setup)

  ;; flycheck
  (setq flycheck-checker 'python-flake8
        flycheck-flake8rc (expand-file-name "~/.config/flake8"))

  ;; autopair
  (setq autopair-handle-action-fns
        '(autopair-default-handle-action autopair-python-triple-quote-action)))

(add-hook 'python-mode-hook 'my/python-mode-hook)
