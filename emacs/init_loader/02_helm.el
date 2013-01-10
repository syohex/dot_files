;;;; helm
(require 'helm-config)
(require 'helm-gtags)
(require 'helm-ack)
(require 'helm-descbinds)
(require 'helm-myutils)

;; configuration helm variable
(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0)
(setq helm-candidate-number-limit 500)
(helm-descbinds-install)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

;; helm-ack
(setq helm-c-ack-insert-at-point 'symbol)

;; helm faces
(require 'helm-files)
(set-face-attribute 'helm-ff-file nil
                    :foreground "white" :background nil)
(set-face-attribute 'helm-ff-directory nil
                    :foreground "white" :background nil :underline t)
