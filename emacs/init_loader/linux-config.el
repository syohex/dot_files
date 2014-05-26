;; This value should be set before loading `mozc.el'
(custom-set-variables
 '(default-input-method "japanese-mozc")
 '(mozc-candidate-style 'echo-area)  ;; overlay is too slow
 '(mozc-leim-title "[も]"))

(require 'mozc)
(global-set-key (kbd "C-o") 'toggle-input-method)

;; browse
(custom-set-variables
 '(browse-url-browser-function 'browse-url-generic)
 '(browse-url-generic-program "firefox"))

;; font-setting for Linux(Ubuntu)

(defun change-font-size (size)
  (interactive
   (list (read-number "Size: ")))
  (set-frame-font (format "VL ゴシック-%d" size)))

(with-temp-buffer
  (call-process "xdpyinfo" nil t)
  (goto-char (point-min))
  (when (re-search-forward "dimensions:\\s-+\\([0-9]+\\)x\\(?:[0-9]+\\)" nil t)
    (let* ((width (string-to-number (match-string-no-properties 1)))
           (size (if (>= width 1900) 12 10)))
      (condition-case err
          (let ((myfont (format "VL ゴシック-%d" size)))
            (set-frame-font myfont)
            (add-to-list 'default-frame-alist `(font . ,myfont)))
        (error (message "%s" err))))))
