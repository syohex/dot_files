;; setting for flymake
(require 'flymake)
(require 'flycheck)

;; Show error message under current line
(require 'popup)
(defun flymake-display-err-menu-for-current-line ()
  (interactive)
  (let* ((line (flymake-current-line-no))
         (line-err-info (flymake-find-err-info flymake-err-info line))
         (error-infos (nth 0 line-err-info))
         (eof-char (char-to-string 0)))
    (when error-infos
      (loop for error-info in error-infos
            for message = (flymake-ler-text error-info)
            for file    = (flymake-ler-file error-info)
            for line    = (flymake-ler-line error-info)
            for filemsg = (or (and file " - %s(%d)" file line) "")

            ;; @@ haskell error message contain EOF
            for removed-eof = (replace-regexp-in-string eof-char "\n" message)
            collect (format "%s%s" removed-eof filemsg) into messages
            finally
            (popup-tip (mapconcat 'identity
                                  (delete-duplicates messages :test #'string=)
                                  "\n"))))))

;; If you don't set :height, :bold face parameter of 'pop-tip-face,
;; then seting those default values
(if (eq 'unspecified (face-attribute 'popup-tip-face :height))
    (set-face-attribute 'popup-tip-face nil :height 1.0))
(if (eq 'unspecified (face-attribute 'popup-tip-face :weight))
    (set-face-attribute 'popup-tip-face nil :weight 'normal))

(defun my/display-error-message ()
  (let ((orig-face (face-attr-construct 'popup-tip-face)))
    (set-face-attribute 'popup-tip-face nil
                        :height 1.5 :foreground "firebrick"
                        :background "LightGoldenrod1" :bold t)
    (unwind-protect
        (flymake-display-err-menu-for-current-line)
      (while orig-face
        (set-face-attribute 'popup-tip-face nil (car orig-face) (cadr orig-face))
        (setq orig-face (cddr orig-face))))))

(defadvice flymake-goto-prev-error (after flymake-goto-prev-error-display-message)
  (my/display-error-message))
(defadvice flymake-goto-next-error (after flymake-goto-next-error-display-message)
  (my/display-error-message))

(ad-activate 'flymake-goto-prev-error 'flymake-goto-prev-error-display-message)
(ad-activate 'flymake-goto-next-error 'flymake-goto-next-error-display-message)

;; avoid abnormal exit
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)

;; helm flymake
(defun helm-c-flymake-init ()
  (with-current-buffer helm-current-buffer
    (loop with eof-char = (char-to-string 0)
          for err in flymake-err-info
          for line   = (car err)
          for detail = (aref (caar (cdr err)) 4)
          for msg    = (replace-regexp-in-string eof-char " " detail)
          for errmsg = (format "%5d: %s" line msg)
          collect (cons errmsg line))))

(defvar helm-c-flymake-source
  '((name . "Error and Warnings")
    (candidates . helm-c-flymake-init)
    (action . (lambda (c)
                (goto-line c helm-current-buffer)))
    (valatile)))

(defun helm-flymake ()
  (interactive)
  (helm :sources '(helm-c-flymake-source)
        :buffer (get-buffer-create "*helm flymake*")))
