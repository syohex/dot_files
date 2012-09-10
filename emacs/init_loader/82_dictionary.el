;; SDIC dictonary for Linux
(autoload 'sdic-describe-word "sdic" "search word" t nil)
(global-set-key (kbd "C-c w") 'sdic-describe-word)

(eval-after-load "sdic"
  '(progn
     (global-set-key (kbd "C-c W") 'sdic-describe-word-at-point)
     (setq sdic-default-coding-system 'utf-8)

     (setq sdicf-array-command "/usr/bin/sary") ;; my modified sary command path
     (setq sdic-eiwa-dictionary-list
           '((sdicf-client "/home/syohei/local/dict/eijiro127.sdic"
                           (strategy array))))
     (setq sdic-waei-dictionary-list
           '((sdicf-client "/home/syohei/local/dict/waeiji127.sdic"
                           (strategy array))))
     ;; saryを直接使用できるように sdicf.el 内に定義されている
     ;; arrayコマンド用関数を強制的に置換
     (fset 'sdicf-array-init 'sdicf-common-init)
     (fset 'sdicf-array-quit 'sdicf-common-quit)
     (fset 'sdicf-array-search
           (lambda (sdic pattern &optional case regexp)
             (sdicf-array-init sdic)
             (if regexp
                 (signal 'sdicf-invalid-method '(regexp))
               (save-excursion
                 (set-buffer (sdicf-get-buffer sdic))
                 (delete-region (point-min) (point-max))
                 (apply 'sdicf-call-process
                        sdicf-array-command
                        (sdicf-get-coding-system sdic)
                        nil t nil
                        (if case
                            (list "-i" pattern (sdicf-get-filename sdic))
                          (list pattern (sdicf-get-filename sdic))))
                 (goto-char (point-min))
                 (let (entries)
                   (while (not (eobp)) (sdicf-search-internal))
                   (nreverse entries))))))

     (defadvice sdic-search-eiwa-dictionary (after highlight-phrase (arg) activate)
       (highlight-phrase arg "hi-yellow"))
     (defadvice sdic-search-waei-dictionary (after highlight-phrase (arg) activate)
       (highlight-phrase arg "hi-yellow"))

     ;; omake
     (defadvice sdic-forward-item (after sdic-forward-item-always-top activate)
       (recenter 0))
     (defadvice sdic-backward-item (after sdic-backward-item-always-top activate)
       (recenter 0))))

(defun sdic-popup-last-word ()
  (interactive)
  (pop-to-buffer "*sdic*"))

;;;; dictionary-with-ace
(defvar dictionary-with-ace:orig-point nil)

(defvar dictionary-with-ace:action
  (lambda (word)
    (sdic-describe-word word)))

(defun dictionary-with-ace:after-moving ()
  (let ((word (substring-no-properties (thing-at-point 'word))))
    (goto-char dictionary-with-ace:orig-point)
    (funcall dictionary-with-ace:action word)
    (setq dictionary-with-ace:not-match-one nil)
    (dictionary-with-ace:remove-hooks)))

(defun dictionary-with-ace:remove-hooks ()
  (remove-hook 'ace-jump-mode-end-hook 'dictionary-with-ace:after-moving)
  (remove-hook 'ace-jump-mode-hook 'dictionary-with-ace:check))

(defvar dictionary-with-ace:not-match-one nil)

(defun dictionary-with-ace:check ()
  (setq dictionary-with-ace:not-match-one t))

(defun dictionary-with-ace ()
  (interactive)
  (let ((c (read-char "Input Char >> ")))
    (setq dictionary-with-ace:orig-point (point))
    (setq ace-jump-query-char c)
    (setq ace-jump-current-mode 'ace-jump-word-mode)
    (add-hook 'ace-jump-mode-hook 'dictionary-with-ace:check)
    (add-hook 'ace-jump-mode-end-hook 'dictionary-with-ace:after-moving)
    (let ((noerror (ignore-errors
                     (ace-jump-do (concat "\\b" (regexp-quote (make-string 1 c))))
                     t)))
      (if (not noerror)
          (dictionary-with-ace:remove-hooks)
        (if (not dictionary-with-ace:not-match-one)
            (dictionary-with-ace:after-moving))))))
