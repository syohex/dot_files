;; ocaml-mode
(add-to-list 'load-path "~/.emacs.d/ocaml-mode")
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
