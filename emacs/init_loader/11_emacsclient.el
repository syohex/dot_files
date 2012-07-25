;; install emacsclient scripts
;; $ git clone git@github.com:syohex/emacsclient_focus.git

;; server start for emacs-client
(require 'server)

(when window-system
  (defadvice server-start
    (after server-start-after-write-window-id ())
    (call-process "emacs_serverstart.pl"
                  nil nil nil
                  (number-to-string (emacs-pid))
                  (if window-system
                      "x"
                    "nox")))
  (ad-activate 'server-start))

(unless (server-running-p)
  (server-start))
