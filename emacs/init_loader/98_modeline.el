;; setting for modeline

;; short names of minor-mode
(setcar (cdr (assq 'flymake-mode minor-mode-alist)) " Fm")
(setcar (cdr (assq 'paredit-mode minor-mode-alist)) " Pe")
