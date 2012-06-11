;; Emacs lisp install file

;; first eval this code block
(add-to-list 'load-path "~/.emacs.d/auto-install")
;; for auto-install
(require 'auto-install)
(auto-install-compatibility-setup)
(auto-install-update-emacswiki-package-name t)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; anything インタフェース周りの全体的な改善
(auto-install-batch "anything")

;; anything-c-moccur
(auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")

;; anything-hatena-bookmark
(auto-install-from-url "https://raw.github.com/k1LoW/anything-hatena-bookmark/master/anything-hatena-bookmark.el")

;; anything-git-grep
(auto-install-from-url "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/screen-base.el")
(auto-install-from-url "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/screen-vc.el")
(auto-install-from-url "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/screen-vc-anything.el")
(auto-install-from-url "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/anything-git-grep.el")

;; color-moccur Emacs内の grep. 再帰的にもできる. 外部プログラム不要
(auto-install-from-emacswiki "color-moccur.el")

;; moccur-edit moccurで抽出した行に対して変更を加えることができる.
(auto-install-from-emacswiki "moccur-edit.el")

;; redo+. undoの逆を行う.
(auto-install-from-emacswiki "redo+.el")

;; recentf-ext. 最近開いたファイルを表示, オープンすることができる
(auto-install-from-emacswiki "recentf-ext.el")

;; viewer. viewモードの機能強化. Modelineの色変更が簡単にできる
(auto-install-from-emacswiki "http://www.emacswiki.org/emacs/download/viewer.el")

;; emacs-w3m
;; emacs-w3m should be installed from CVS
;; cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
(auto-install-from-url "http://www.emacswiki.org/emacs/download/w3m-session.el")

;; iman emacsの manの補完
(auto-install-from-url "http://homepage1.nifty.com/bmonkey/emacs/elisp/iman.el")

;; text-translator 翻訳
(auto-install-batch "text translator")

;; pod-mode
(auto-install-from-url "https://github.com/renormalist/emacs-pod-mode/raw/master/pod-mode.el")

;; eldoc-extension
(auto-install-from-emacswiki "eldoc-extension.el")

;; savekill
(auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/savekill.el")

;; cl-indent-patche.el
(auto-install-from-url "http://boinkor.net/lisp/cl-indent-patches.el")

;; auto-save-buffer
(auto-install-from-url "http://0xcc.net/misc/auto-save/auto-save-buffers.el")

;; perl-completion
(auto-install-from-url "http://www.emacswiki.org/emacs/download/perl-completion.el")

;; thing-opt
(auto-install-from-url "http://www.emacswiki.org/emacs/download/thing-opt.el")

;; xs-mode
(auto-install-from-url "http://www.emacswiki.org/emacs/download/xs-mode.el")

;; ac-python
(auto-install-from-url "http://chrispoole.com/downloads/ac-python.el")

;; auto-complete-clang
(auto-install-from-url
 "https://raw.github.com/brianjcj/auto-complete-clang/master/auto-complete-clang.el")

;; direx(new dired)
(auto-install-from-url "https://raw.github.com/m2ym/direx-el/master/direx.el")

;; terminal multiplexer
(auto-install-from-url "https://raw.github.com/m2ym/emux-el/master/emux.el")

;; for source code reading
(auto-install-from-url "https://raw.github.com/takaishi/succor/master/succor.el")
