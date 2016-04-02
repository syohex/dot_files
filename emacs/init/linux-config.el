;; Linux specific configuration
(custom-set-variables
 '(browse-url-browser-function #'browse-url-xdg-open))

;; key config
(global-set-key (kbd "C-x ?") 'zeal-at-point)

;; font-setting for Linux(Ubuntu)
(defun change-font-size (size)
  (interactive
   (list (read-number "Size: ")))
  (set-frame-font (format "VL ゴシック-%d" size)))

(let ((size (if (>= (x-display-pixel-width) 1900) 14 10)))
  (condition-case err
      (let ((myfont (format "VL ゴシック-%d" size)))
	(set-frame-font myfont)
	(add-to-list 'default-frame-alist `(font . ,myfont)))
    (error (message "%s" err))))
