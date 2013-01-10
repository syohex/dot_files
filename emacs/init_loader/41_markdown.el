;; setting markdown-mode
(add-to-list 'auto-mode-alist '("\\.\\(md\\|mdt\\|mdwn\\)$" . markdown-mode))
(autoload 'markdown-mode "markdown-mode" nil t)

(eval-after-load "markdown-mode"
  '(progn
     (setq markdown-command "Markdown.pl")

     (add-hook 'markdown-mode-hook 'my/markdown-mode-hook)))

(defun my/markdown-mode-hook ()
  (add-to-list 'ac-sources 'ac-source-look))
