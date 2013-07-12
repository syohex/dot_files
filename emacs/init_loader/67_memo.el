;; my memo utility
(defvar my/memo-directory (expand-file-name "~/memo/daily/"))

(defun my/open-daily-memo ()
  (interactive)
  (let ((default-directory my/memo-directory))
    (let ((dir (format-time-string "%Y/%m/"))
          (today (format-time-string "%d")))
      (unless (file-directory-p dir)
        (make-directory dir t))
      (let* ((file (concat default-directory dir today ".org"))
             (created (file-exists-p file)))
        (find-file file)
        (unless created
          (insert (format-time-string "%Y年%b %e日 タスクリスト")))
        (show-all)))))

(global-set-key (kbd "<f11>") 'my/open-daily-memo)
