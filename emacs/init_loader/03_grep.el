;; grep setting
(require 'grep)
(grep-apply-setting 'grep-find-command "ack --nocolor --nogroup ")
(global-set-key (kbd "M-g M-f") 'find-grep)
