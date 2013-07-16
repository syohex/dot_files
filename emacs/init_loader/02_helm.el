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
(global-set-key (kbd "C-;") 'helm-myutils:git-project)
(global-set-key (kbd "<f10>") 'helm-myutils:dropbox)
(global-set-key (kbd "C-x v g") 'helm-myutils:git-grep)
(global-set-key (kbd "C-M-s") 'helm-ag-this-file)

;; helm faces
(require 'helm-files)
(set-face-attribute 'helm-ff-file nil
                    :foreground "white" :background nil)
(set-face-attribute 'helm-ff-directory nil
                    :foreground "cyan" :background nil :underline t)

(set-face-attribute 'helm-source-header nil
                    :height 1.0)

;; my helm utilities
(defun helm-myutils:git-project-source (pwd)
  (loop for (description . option) in
        '(("Modified files" . "--modified")
          ("Untracked files" . "--others --exclude-standard")
          ("All controlled files in this project" . ""))
        for cmd = (format "git ls-files %s" option)
        collect
        `((name . ,(format "%s [%s]" description pwd))
          (init . (lambda ()
                    (with-current-buffer (helm-candidate-buffer 'global)
                      (call-process-shell-command ,cmd nil t))))
          (candidates-in-buffer)
          (action . (("Open File" . find-file)
                     ("Open File other window" . find-file-other-window)
                     ("Insert buffer" . insert-file))))))

(defun helm-myutils:git-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))

(defun helm-myutils:git-grep-source ()
  `((name . ,(format "Grep at %s" default-directory))
    (init . helm-myutils:git-grep-init)
    (candidates-in-buffer)
    (type . file-line)))

(defun helm-myutils:git-grep-init ()
  (helm-attrset 'recenter t)
  (with-current-buffer (helm-candidate-buffer 'global)
    (let ((cmd (read-string "Grep: " "git grep -n ")))
      (call-process-shell-command cmd nil t))))

;;;###autoload
(defun helm-myutils:git-grep ()
  (interactive)
  (let ((default-directory (helm-myutils:git-topdir)))
    (helm :sources (helm-myutils:git-grep-source) :buffer "*helm git*")))

;;;###autoload
(defun helm-myutils:git-project ()
  (interactive)
  (let ((topdir (helm-myutils:git-topdir)))
    (unless (file-directory-p topdir)
      (error "I'm not in Git Repository!!"))
    (let ((default-directory topdir)
          (sources (helm-myutils:git-project-source
                    (file-name-nondirectory
                     (directory-file-name topdir)))))
      (helm-other-buffer sources "*helm git project*"))))
