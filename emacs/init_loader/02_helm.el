;;;; helm
(require 'helm-config)
(require 'helm-gtags)

;; configuration helm variable
(setq helm-idle-delay 0.2)
(setq helm-input-idle-delay 0)
(setq helm-candidate-number-limit 100)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

;; helm faces
(require 'helm-files)
(set-face-attribute 'helm-ff-file nil
                    :foreground "white" :background nil)
(set-face-attribute 'helm-ff-directory nil
                    :foreground "tomato" :background nil
                    :underline t)

;; List files in git repos
(defun helm-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files (%s)" . "--modified")
          ("Untracked files (%s)" . "--others --exclude-standard")
          ("All controlled files in this project (%s)" . ""))
        collect
        `((name . ,(format (car elt) pwd))
          (init . (lambda ()
                    (unless (and ,(string= (cdr elt) "")
                                 (helm-candidate-buffer))
                      (with-current-buffer (helm-candidate-buffer 'global)
                        (shell-command
                         ,(format "git ls-files $(git rev-parse --show-cdup) %s" (cdr elt))
                         t)))))
          (candidates-in-buffer)
          (type . file))))

(defun helm-git-project-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))

(defun helm-git-project ()
  (interactive)
  (let ((topdir (helm-git-project-topdir)))
    (unless (file-directory-p topdir)
      (error "I'm not in Git Repository!!"))
    (let* ((default-directory topdir)
           (sources (helm-c-sources-git-project-for default-directory)))
      (helm-other-buffer sources
                         (format "*helm git project in %s*" default-directory)))))
(define-key global-map (kbd "C-;") 'helm-git-project)
