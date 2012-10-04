;; setting markdown-mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.\\(md\\|mdt\\|mdwn\\)$" . markdown-mode))
(setq markdown-command "Markdown.pl")
