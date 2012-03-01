;; font-setting for Linux(Ubuntu)

(when (and window-system (system-linux-p))
  (with-temp-buffer
    (shell-command "xdpyinfo" t)
    (goto-char (point-min))
    (when (re-search-forward "dimensions:\s+\\([0-9]+\\)x\\([0-9]+\\)" nil t)
      (let ((width (string-to-int (buffer-substring-no-properties
                                   (match-beginning 1) (match-end 1))))
            (height (string-to-int (buffer-substring-no-properties
                                    (match-beginning 2) (match-end 2)))))
        (cond
         ((>= width 1900) (set-default-font "VL ゴシック-12"))
         (t (set-default-font "VL ゴシック-10")))))))

;; font-setting for Mac OSX
(when (and window-system (system-macosx-p))
 (set-face-attribute 'default nil
                     :family "monaco"
                     :height 120)
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0208
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'japanese-jisx0212
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'katakana-jisx0201
  '("Hiragino Maru Gothic Pro" . "iso10646-1"))
 (set-fontset-font
  (frame-parameter nil 'font)
  'mule-unicode-0100-24ff
  '("monaco" . "iso10646-1"))
 (setq face-font-rescale-alist
      '(("^-apple-hiragino.*" . 1.2)
        (".*osaka-bold.*" . 1.2)
        (".*osaka-medium.*" . 1.2)
        (".*courier-bold-.*-mac-roman" . 1.0)
        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
        (".*monaco-bold-.*-mac-roman" . 0.9)
        ("-cdac$" . 1.3))))
