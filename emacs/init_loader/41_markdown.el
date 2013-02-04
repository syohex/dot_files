;; setting markdown-mode
(add-to-list 'auto-mode-alist '("\\.\\(md\\|mdt\\|mdwn\\)$" . markdown-mode))
(autoload 'markdown-mode "markdown-mode" nil t)

(eval-after-load "markdown-mode"
  '(progn
     (setq markdown-command "Markdown.pl")
     (add-hook 'markdown-mode-hook 'my/markdown-mode-hook)))

(defun my/markdown-imenu-create-index ()
  (save-excursion
    (goto-char (point-min))
    (loop while (re-search-forward "^\\(#+\\)\\s-+\\(.+\\)$" nil t)
          for hash-marks = (match-string-no-properties 1)
          for header     = (match-string-no-properties 2)
          collect
          (cons (format "H%d: %s" (length hash-marks) header)
                (match-beginning 0)))))

(defun my/markdown-mode-hook ()
  (set (make-local-variable 'imenu-create-index-function)
       'my/markdown-imenu-create-index)
  (add-to-list 'ac-sources 'ac-source-look))
