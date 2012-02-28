;; setting markdown-mode
;; (install-elisp "http://jblevins.org/projects/markdown-mode/markdown-mode.el")
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.\\(md\\|mdt\\|mdwn\\)$" . markdown-mode))
(setq markdown-command "Markdown.pl")
