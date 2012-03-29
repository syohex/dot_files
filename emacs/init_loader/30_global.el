;;;; GNU gtags
;; (auto-install-from-url "http://cvs.savannah.gnu.org/viewvc/*checkout*/global/gtags.el?root=global")
(require 'gtags)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key (kbd "M-t") 'gtags-find-tag)
         (local-set-key (kbd "M-r") 'gtags-find-rtag)
         (local-set-key (kbd "M-s") 'gtags-find-symbol)
         (local-set-key (kbd "C-t") 'gtags-pop-stack)))

;;; hook for gtags
(add-hook 'c-mode-common-hook 'gtags-mode)
(add-hook 'c++-mode-hook 'gtags-mode)
(add-hook 'java-mode-hook 'gtags-mode)
(add-hook 'asm-mode 'gtags-mode)
