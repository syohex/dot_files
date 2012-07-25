;; grep setting
(require 'grep)
(grep-apply-setting 'grep-find-command "ack --nocolor --nogroup ")

(defvar simple-grep-default-command
  "ack --nocolor --nogroup ")

(defun simple-grep ()
  (interactive)
  (let ((cmd (read-string "Grep: " simple-grep-default-command))
        (buf (get-buffer-create "*Simple Grep*")))
    (with-current-buffer buf
      (setq buffer-read-only nil)
      (erase-buffer)
      (call-process-shell-command cmd nil t nil))
    (pop-to-buffer buf)
    (goto-char (point-min))
    (grep-mode)))
