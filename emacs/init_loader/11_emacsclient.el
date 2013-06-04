;; server start for emacs-client
(require 'server)

(when (and (not (macosx-p)) (executable-find "emacs_serverstart.pl"))
  (defadvice server-start
    (after server-start-after-write-window-id ())
    (let* ((x-param (if window-system "x" "nox"))
           (pid (emacs-pid))
           (cmd (format "emacs_serverstart.pl %d %s" pid x-param)))
      (call-process-shell-command cmd)))
  (ad-activate 'server-start))

(unless (server-running-p)
  (server-start))
