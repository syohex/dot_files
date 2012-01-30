;; anything
(require 'anything-gtags)
(require 'anything-match-plugin)
(require 'anything-complete)
(require 'anything-config)
(require 'anything-migemo)
(require 'anything-grep)
(require 'anything)

;; configuration anything variable
(setq anything-idle-delay 0.2)
(setq anything-input-idle-delay 0)
(setq anything-candidate-number-limit 100)

(setq anything-sources (list anything-c-source-buffers+
                             anything-c-source-file-name-history
                             anything-c-source-man-pages
                             anything-c-source-info-pages))

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-M-n") 'anything-next-source)
(define-key anything-map (kbd "C-M-p") 'anything-previous-source)

;; anything
(global-set-key (kbd "C-x C-c") 'anything-M-x)

;; anything-show-kill-ring
(global-set-key (kbd "M-y") 'anything-show-kill-ring)

;; apropos with anything
(global-set-key (kbd "C-h a") 'anything-apropos)
(global-set-key (kbd "C-h h") 'anything-apropos)

;; anything-imenu
(global-set-key (kbd "C-x C-i") 'anything-imenu)

;; anything faces
(when (not window-system)
  (set-face-background 'anything-visible-mark "orange")
  (set-face-background 'highlight 'nil)
  (set-face-underline-p 'highlight t))

;; anything-project
(require 'anything-project)
(global-set-key (kbd "C-c C-f") 'anything-project)

(ap:add-project
 :name 'perl
 :look-for '("Makefile.PL" "Build.PL")
 :include-regexp '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$" "\\.xs$" "Changes")
 :exclude-regexp '("/inc" "/blib"))

;; anything
(require 'anything-git-grep)

;; M-x anything-grep-by-name
(setq anything-grep-alist
      '(("auto-install" ("grep -Hin %s *.el" "~/.emacs.d/auto-install/"))
        ("emacs-config" ("grep -Hin %s *.el" "~/.emacs.d/init_loader/"))
        ("todo" ("grep -Hin %s notes.org" "~/.emacs.d/"))))
