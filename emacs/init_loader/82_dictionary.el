;; SDIC dictonary for Linux
(when (system-linux-p)
  (global-set-key "\C-cw" 'sdic-describe-word)
  (global-set-key "\C-cW" 'sdic-describe-word-at-point)
  (setq sdic-default-coding-system 'utf-8)
  (autoload 'sdic-describe-word "sdic" "search word" t nil))

(eval-after-load "sdic"
  '(progn
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

;; dictionary setting for mac
(require 'cl)
(require 'popwin)

(when (system-macosx-p)
  (require 'popup)
  (define-key global-map (kbd "C-M-d") 'ns-popup-dictionary))

(defun ns-popup-dictionary ()
  "Search word from dictionary"
  (interactive)
  (let ((word (substring-no-properties (thing-at-point 'word)))
        (dict-buf (get-buffer-create "*dictionary.app*")))
    (with-current-buffer dict-buf
      (erase-buffer)
      (insert "[" word "]\n")
      (call-process "dict.py" nil "*dictionary.app*" t word))
    (popwin:popup-buffer dict-buf)))
