;; eshell
(require 'eshell)

(setq eshell-hist-ignoredups t)
(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-cutoff-length 5)

(require 'pcomplete)
(add-to-list 'ac-modes 'eshell-mode)
(ac-define-source pcomplete
  '((candidates . pcomplete-completions)))

(defun my/ac-eshell-mode ()
  (setq ac-sources
        '(ac-source-pcomplete
          ac-source-words-in-buffer
          ac-source-dictionary)))

(add-hook 'eshell-mode-hook
          (lambda ()
            (my/ac-eshell-mode)
            (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
            (define-key eshell-mode-map (kbd "C-j") 'auto-complete)))

(require 'ansi-color)
(add-hook 'eshell-mode-hook 'ansi-color-for-comint-mode-on)

(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

(custom-set-faces
 '(eshell-prompt ((t (:foreground "gold1" :bold t)))))

;; disable eshell command
(progn
 (defmacro eval-after-load* (name &rest body)
   (declare (indent 1))
   `(eval-after-load ,name '(progn ,@body)))
 (defun eshell-disable-unix-command-emulation ()
   (eval-after-load* "em-ls"
     (fmakunbound 'eshell/ls))
   (eval-after-load* "em-unix"
     (mapc 'fmakunbound '(eshell/agrep
                          eshell/basename
                          eshell/cat
                          eshell/cp
                          eshell/date
                          eshell/diff
                          eshell/dirname
                          eshell/du
                          eshell/egrep
                          eshell/fgrep
                          eshell/glimpse
                          eshell/grep
                          eshell/info
                          eshell/ln
                          eshell/locate
                          eshell/make
                          eshell/man
                          eshell/mkdir
                          eshell/mv
                          eshell/occur
                          eshell/rm
                          eshell/rmdir
                          eshell/su
                          eshell/sudo
                          eshell/time))))
 (eshell-disable-unix-command-emulation))

;; aliases
(eval-after-load "em-alias"
  '(progn
     (eshell/alias "cdp" "cd {git rev-parse --show-toplevel}")))

;; pcomplete for git
(defconst pcmpl-git-commands
  '("add" "bisect" "branch" "checkout" "clone"
    "commit" "diff" "fetch" "grep"
    "init" "log" "merge" "mv" "pull" "push" "rebase"
    "reset" "rm" "show" "status" "tag" )
  "List of `git' commands")

(defvar pcmpl-git-ref-list-cmd "git for-each-ref refs/ --format='%(refname)'"
  "The `git' command to run to get a list of refs")

(defun pcmpl-git-get-refs (type)
  "Return a list of `git' refs filtered by TYPE"
  (with-temp-buffer
    (insert (shell-command-to-string pcmpl-git-ref-list-cmd))
    (goto-char (point-min))
    (let ((ref-list))
      (while (re-search-forward (concat "^refs/" type "/\\(.+\\)$") nil t)
        (add-to-list 'ref-list (match-string 1)))
      ref-list)))

(defun pcmpl-git-get-aliases ()
  (with-temp-buffer
    (call-process "git" nil t t "config" "--global" "-l")
    (goto-char (point-min))
    (let ((lst nil))
      (while (re-search-forward "^alias\.\\([^=]+\\)" nil t)
        (push (buffer-substring-no-properties (match-beginning 1) (match-end 1))
              lst))
      lst)))

(defvar pcmpl-git-aliases (pcmpl-git-get-aliases))

(defun pcomplete/git ()
  "Completion for `git'"
  ;; Completion for the command argument.
  (pcomplete-here* (append pcmpl-git-aliases pcmpl-git-commands))
  ;; complete files/dirs forever if the command is `add' or `rm'
  (cond
   ((pcomplete-match (regexp-opt '("add" "rm")) 1)
    (while (pcomplete-here (pcomplete-entries))))
   ;; provide branch completion for the command `checkout'.
   ((pcomplete-match "checkout" 1)
    (pcomplete-here* (pcmpl-git-get-refs "heads")))))
