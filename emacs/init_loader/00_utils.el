;; predicate, Is your system Mac OSX
(defun system-macosx-p ()
  (string= system-type "darwin"))

;; predicate, Is your system Linux
(defun system-linux-p ()
  (string= system-type "gnu/linux"))

;; number-rectangle
(eval-when-compile (require 'cl))
(defun number-rectangle (start end format-string from)
  "Delete (don't save) text in the region-rectangle, then number it."
  (interactive
   (list (region-beginning) (region-end)
         (read-string "Number rectangle: " (if (looking-back "^ *") "%d. " "%d"))
         (read-number "From: " 1)))
  (save-excursion
    (goto-char start)
    (setq start (point-marker))
    (goto-char end)
    (setq end (point-marker))
    (delete-rectangle start end)
    (goto-char start)
    (loop with column = (current-column)
          while (and (<= (point) end) (not (eobp)))
          for i from from   do
          (move-to-column column t)
          (insert (format format-string i))
          (forward-line 1)))
  (goto-char start))

(global-set-key "\C-xrN" 'number-rectangle)

;; insert line number
(defun insert-line-number-region (rb re)
  "Insert line number at each line"
  (interactive "r")
  (let* ((i 1)
         (lines (+ (- (line-number-at-pos re) (line-number-at-pos rb)) 1))
         (digit-length (length (number-to-string lines)))
         (line-format (concat "%" (number-to-string digit-length) "d:")))
    (save-excursion
      (goto-char rb)
      (beginning-of-line)
      (while (<= i lines)
        (insert (format line-format i))
        (unless (eolp)
          (insert " "))
        (forward-line 1)
        (setq i (+ i  1))))))
