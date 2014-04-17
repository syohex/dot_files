;; Emacs lisp install file

(require 'cl-lib)

(defvar my/elisp-directory)
(defvar my/init-loader-directory)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name))
  (setq custom-theme-directory (concat user-emacs-directory "elisps/")))

(setq my/elisp-directory (concat user-emacs-directory "elisps/"))
(unless (file-directory-p my/elisp-directory)
  (make-directory my/elisp-directory))

(setq my/init-loader-directory (concat user-emacs-directory "init_loader"))
(unless load-file-name
  (unless (file-symlink-p my/init-loader-directory)
    (make-symbolic-link (concat default-directory "init_loader")
                        user-emacs-directory)))

;; first eval this code block
(add-to-list 'load-path my/elisp-directory)

;; check commands
(dolist (cmd '("curl" "cask"))
  (unless (executable-find cmd)
    (error "Please install %s" cmd)))

;; Emacs package system
(require 'cask "~/.cask/cask.el")
(cask-initialize user-emacs-directory)

(defun my/download-url (url)
  (assert (stringp url))
  (if (zerop (call-process "curl" nil nil nil "-O" url))
      (message "Success Download %s" url)
    (message "Failed Download %s" url)))

(cl-defun my/system (&rest cmds)
  (dolist (cmd cmds)
    (message "Execute '%s'" cmd)
    (unless (zerop (call-process-shell-command cmd))
      (error "%s is failed!!" cmd))))

(defvar my/nonelpa-packages-url
  '(
    ;; 3rd pirty
;;    "http://www.neilvandyke.org/quack/quack.el"
    ))

;; setup nonelpa packages
(let ((default-directory my/elisp-directory))
  (dolist (url my/nonelpa-packages-url)
    (unless (file-exists-p (file-name-nondirectory url))
      (my/download-url url))))

;; Hyperspec
(let ((default-directory my/elisp-directory))
  (when (not (file-directory-p "HyperSpec"))
    (message "Install HyperSpec(Wait a minute)")
    (unless (file-exists-p "HyperSpec-7-0.tar.gz")
      (my/download-url "ftp://ftp.lispworks.com/pub/software_tools/reference/HyperSpec-7-0.tar.gz"))
    (my/system "tar xf HyperSpec-7-0.tar.gz"
               "rm -f HyperSpec-7-0.tar.gz")))

(load-theme 'reverse t t)
(enable-theme 'reverse)

(init-loader-load my/init-loader-directory)
