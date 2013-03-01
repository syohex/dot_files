;;;; helm
(require 'helm-config)
(require 'helm-descbinds)
(require 'helm-myutils)

;; autoload
(autoload 'helm-ack "helm-ack" nil t)
(autoload 'helm-ack-current-file "helm-ack" nil t)

;; configuration helm variable
(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0)
(setq helm-candidate-number-limit 500)
(helm-descbinds-install)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)
(global-set-key (kbd "C-;") 'helm-myutils:git-project)
(global-set-key (kbd "<f10>") 'helm-myutils:dropbox)
(global-set-key (kbd "C-x C-p") 'helm-myutils:files-in-curdir)

(remove-hook 'kill-emacs-hook 'helm-adaptive-save-history)

;; helm-ack
(setq helm-c-ack-insert-at-point 'symbol)

;; helm faces
(require 'helm-files)
(set-face-attribute 'helm-ff-file nil
                    :foreground "white" :background nil)
(set-face-attribute 'helm-ff-directory nil
                    :foreground "white" :background nil :underline t)

;; helm ack for the file
(defun helm-ack-current-file ()
  (interactive)
  (unless (buffer-file-name)
    (error "This is not file!!"))
  (let ((helm-c-ack-insert-at-point nil))
    (helm-ack -1)))
(global-set-key (kbd "C-M-s") 'helm-ack-current-file)
