;;;; anything
;; (auto-install-batch "anything")
(require 'anything-gtags)
(require 'anything-match-plugin)
(require 'anything-complete)
(require 'anything-config)
(require 'anything-migemo)
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

;; anything
(autoload 'anything-git-grep "anything-git-grep")

;; List files in git repos
(defun anything-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files (%s)" . "--modified")
          ("Untracked files (%s)" . "--others --exclude-standard")
          ("All controlled files in this project (%s)" . ""))
        collect
        `((name . ,(format (car elt) pwd))
          (init . (lambda ()
                    (unless (and ,(string= (cdr elt) "")
                                 (anything-candidate-buffer))
                      (with-current-buffer (anything-candidate-buffer 'global)
                        (shell-command
                         ,(format "git ls-files $(git rev-parse --show-cdup) %s" (cdr elt))
                         t)))))
          (candidates-in-buffer)
          (type . file))))

(defun anything-git-project ()
  (interactive)
  (let ((sources (anything-c-sources-git-project-for default-directory)))
    (anything-other-buffer sources
     (format "*Anything git project in %s*" default-directory))))
(define-key global-map (kbd "C-;") 'anything-git-project)
