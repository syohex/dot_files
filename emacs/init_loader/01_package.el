;; Setting package.el
(autoload 'package-install "package" nil t)
(eval-after-load "package"
  '(progn
     (add-to-list 'package-archives
                  '("marmalade" . "http://marmalade-repo.org/packages/"))

     (setq package-user-dir (concat user-emacs-directory "elpa"))
     (package-initialize)))
