;;;; helm
(require 'helm-config)
(require 'helm-descbinds)

;; helm-ag
(custom-set-variables
 '(helm-ag-insert-at-point 'symbol))

;; configuration helm variable
(setq helm-idle-delay 0.1
      helm-input-idle-delay 0
      helm-candidate-number-limit 500)
(helm-descbinds-mode)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

;; helm faces
(require 'helm-files)
(set-face-attribute 'helm-ff-file nil
                    :foreground "white" :background nil)
(set-face-attribute 'helm-ff-directory nil
                    :foreground "cyan" :background nil :underline t)

(set-face-attribute 'helm-source-header nil
                    :height 1.0 :weight 'semi-bold :family nil)

;; my helm utilities
(defun my/helm-git-project-source (pwd)
  (loop for (description . option) in
        '(("Modified Files" . "--modified")
          ("Untracked Files" . "--others --exclude-standard")
          ("All Files" . ""))
        for cmd = (format "git ls-files %s" option)
        collect
        `((name . ,(format "%s (%s)" description pwd))
          (init . (lambda ()
                    (with-current-buffer (helm-candidate-buffer 'global)
                      (call-process-shell-command ,cmd nil t))))
          (candidates-in-buffer)
          (action . (("Open File" . find-file)
                     ("Open File other window" . find-file-other-window)
                     ("Insert buffer" . insert-file))))))

(defun my/helm-git-project-files ()
  (interactive)
  (let ((topdir (locate-dominating-file default-directory ".git/")))
    (unless topdir
      (error "I'm not in Git Repository!!"))
    (let ((default-directory topdir)
          (sources (my/helm-git-project-source topdir)))
      (helm-other-buffer sources "*Helm Git Project*"))))
