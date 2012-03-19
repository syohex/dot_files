;;;; Setting Dart language
;; (auto-install-from-url "https://raw.github.com/nex3/dart-mode/master/dart-mode.el")
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
(autoload 'dart-mode "dart-mode" nil t)
