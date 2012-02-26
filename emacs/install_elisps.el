;; Emacs lisp install file

;; first eval this code block
(add-to-list 'load-path "~/.emacs.d/auto-install")
(require 'auto-install)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; for installing el-get
(url-retrieve
 "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
 (lambda (s)
   (end-of-buffer)
   (eval-print-last-sexp)))

;; anything インタフェース周りの全体的な改善
(auto-install-batch "anything")

;; key-chord 同時押しの実現
(install-elisp-from-emacswiki "key-chord.el")

;; color-moccur Emacs内の grep. 再帰的にもできる. 外部プログラム不要
(install-elisp-from-emacswiki "color-moccur.el")

;; moccur-edit moccurで抽出した行に対して変更を加えることができる.
(install-elisp-from-emacswiki "moccur-edit.el")

;; redo+. undoの逆を行う.
(install-elisp-from-emacswiki "redo+.el")

;; js2-mode moozさんによるフォーク版
;;(install-elisp "https://github.com/mooz/js2-mode/raw/master/js2-mode.el")

;; bm.el 行を任意の行を強調表示できる. 強調表示した行の移動もできる
(install-elisp "http://cvs.savannah.gnu.org/viewvc/*checkout*/bm/bm/bm.el")

;; recentf-ext. 最近開いたファイルを表示, オープンすることができる
(install-elisp-from-emacswiki "recentf-ext.el")

;; htmlize.el emacsのハイライト情報を html化する
(install-elisp "http://fly.srk.fer.hr/~hniksic/emacs/htmlize.el.cgi")

;; gist. Emacsの gist in githubクライアント
(install-elisp "https://github.com/defunkt/gist.el/raw/master/gist.el")

;; viewer. viewモードの機能強化. Modelineの色変更が簡単にできる
(install-elisp-from-emacswiki "http://www.emacswiki.org/emacs/download/viewer.el")

;; twittering-mode
;; twittering-mode shuold be installed from github
; git clone https://github.com/hayamiz/twittering-mode.git

;; popwin. completionバッファなどのポップアップ化(勝手に消してくれる)
(install-elisp "https://github.com/m2ym/popwin-el/raw/master/popwin.el")
(install-elisp "https://raw.github.com/m2ym/popwin-el/master/misc/popwin-w3m.el")

;; emacs-w3m
;; emacs-w3m should be installed from CVS
;; cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
(install-elisp "http://www.emacswiki.org/emacs/download/w3m-session.el")

;; wanderlust
;; wanderlust should be install from github

;; dmacro.el
(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")

;; scala-mode
;; please install scala 'http://www.scala-lang.org/'

;; point-undo. 前のポイントに移動する
;;(install-elisp-from-emacswiki "point-undo.el")

;; goto-chg.el 最後の変更箇所に移動する
;;(install-elisp-from-emacswiki "goto-chg.el")

;; elscreen, elscreen-wl
;; elscreen url ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/

;; iman emacsの manの補完
(install-elisp "http://homepage1.nifty.com/bmonkey/emacs/elisp/iman.el")

;; text-translator 翻訳
(auto-install-batch "text translator")

;; navi2ch
;; git clone https://github.com/kaoru6/navi2ch.git

;; pod-mode
(install-elisp "https://github.com/renormalist/emacs-pod-mode/raw/master/pod-mode.el")

;; gtags-mode
(install-elisp
 "http://cvs.savannah.gnu.org/viewvc/*checkout*/global/gtags.el?root=global")

;; git-commit-mode
(install-elisp
 "https://github.com/rafl/git-commit-mode/raw/master/git-commit.el")

;; smart-compile
;;(install-elisp
;; "http://sourceforge.jp/projects/macwiki/svn/view/zenitani/elisp/smart-compile.el?view=co&root=macwiki")

;; markdown-mode
(install-elisp
 "http://jblevins.org/projects/markdown-mode/markdown-mode.el")

;; deferred.el
(install-elisp
 "http://github.com/kiwanami/emacs-deferred/raw/master/deferred.el")
(install-elisp
 "https://github.com/kiwanami/emacs-deferred/raw/master/concurrent.el")

;;;; deferred.el demo program
;; (install-elisp
;;  "http://github.com/kiwanami/emacs-inertial-scroll/raw/master/inertial-scroll.el")

;; eldoc-extension
(install-elisp-from-emacswiki "eldoc-extension.el")

;; yasnippet
(install-elisp "http://www.emacswiki.org/emacs/download/yasnippet-config.el")

;; savekill
(install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/savekill.el")

;; zen-coding
(install-elisp "https://github.com/rooney/zencoding/raw/master/zencoding-mode.el")

;; shell-pop.el
(install-elisp "http://www.emacswiki.org/emacs/download/shell-pop.el")

;; ac-slime
(install-elisp "https://github.com/purcell/ac-slime/raw/master/ac-slime.el")

;; cl-indent-patche.el
(install-elisp "http://boinkor.net/lisp/cl-indent-patches.el")

;; e2wm
(install-elisp "https://raw.github.com/kiwanami/emacs-window-manager/master/e2wm.el")
(install-elisp "https://raw.github.com/kiwanami/emacs-window-layout/master/window-layout.el")

;; auto-save-buffer
(install-elisp "http://0xcc.net/misc/auto-save/auto-save-buffers.el")

;; smartchr.el
(install-elisp "https://raw.github.com/imakado/emacs-smartchr/master/smartchr.el")

;; clojure-mode
(install-elisp "https://raw.github.com/jochu/clojure-mode/master/clojure-mode.el")

;; paredit-mode
(install-elisp "http://mumble.net/~campbell/emacs/paredit.el")

;; undo-tree
(install-elisp "http://www.dr-qubit.org/undo-tree/undo-tree.el")

;; jaunte.el hit-a-hint
(install-elisp "https://raw.github.com/kawaguchi/jaunte.el/master/jaunte.el")

;; for flymake perl
(install-elisp "http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el")

;; perl-completion
(install-elisp "http://www.emacswiki.org/emacs/download/perl-completion.el")

;; auto-complete-yasnippet
(install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el")

;; thing-opt
(install-elisp "http://www.emacswiki.org/emacs/download/thing-opt.el")

;; el-expectations for unit-test
(auto-install-batch "el-expectations")

;; coffee-mode.el
(install-elisp "https://raw.github.com/defunkt/coffee-mode/master/coffee-mode.el")

;; auto-async-byte-compile
;;(install-elisp "http://www.emacswiki.org/emacs/download/auto-async-byte-compile.el")

;; popwin:w3m
(install-elisp "https://raw.github.com/m2ym/popwin-el/v0.3/misc/popwin-w3m.el")

;; descbinds-anything
(install-elisp "http://www.emacswiki.org/cgi-bin/emacs/download/descbinds-anything.el")

;; xs-mode
(install-elisp "http://www.emacswiki.org/emacs/download/xs-mode.el")

;; anything-c-moccur
(install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")

;; ac-python
(install-elisp "http://chrispoole.com/downloads/ac-python.el")

;; lispxmp
(install-elisp "http://www.emacswiki.org/emacs/download/lispxmp.el")

;; haml-mode and sass-mode
(install-elisp "https://raw.github.com/nex3/haml-mode/master/haml-mode.el")
(install-elisp "https://raw.github.com/nex3/sass-mode/master/sass-mode.el")

;; anything-project
(install-elisp "https://raw.github.com/imakado/anything-project/master/anything-project.el")

;; auto-complete-clang
(auto-install-from-url
 "https://raw.github.com/brianjcj/auto-complete-clang/master/auto-complete-clang.el")

;; pos-tip.el
(auto-install-from-url "http://www.emacswiki.org/emacs/download/pos-tip.el")

;; quickrun
(auto-install-from-url "https://raw.github.com/syohex/emacs-quickrun/master/quickrun.el")

;; highlight-column
(auto-install-from-url "http://www.emacswiki.org/emacs/download/vline.el")
(auto-install-from-url "http://www.emacswiki.org/emacs/download/col-highlight.el")

;; inf-clojure
(auto-install-from-url "https://raw.github.com/syohex/emacs-inf-clojure/master/inf-clojure.el")

;; eshell
(install-elisp "http://www.rubyist.net/~rubikitch/private/esh-myparser.el")
(install-elisp "http://www.rubyist.net/~rubikitch/private/eshell-pop.el")

;; cycle-buffer
(install-elisp-from-emacswiki "cycle-buffer.el")

;; anything-hatena-bookmark
(install-elisp "https://raw.github.com/k1LoW/anything-hatena-bookmark/master/anything-hatena-bookmark.el")

;; anything-git-grep
(install-elisp "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/screen-base.el")
(install-elisp "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/screen-vc.el")
(install-elisp "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/screen-vc-anything.el")
(install-elisp "https://raw.github.com/mechairoi/config/master/.emacs.d/elisp/anything-git-grep.el")

;; direx(new dired)
(install-elisp "https://raw.github.com/m2ym/direx-el/master/direx.el")

;; anything-grep
(install-elisp "http://www.emacswiki.org/cgi-bin/wiki/download/anything-grep.el")

;; smartrep
(install-elisp "http://www.emacswiki.org/emacs/download/smartrep.el")

;; package.el
(install-elisp "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el")

;; for Emacswiki
(install-elisp-from-emacswiki "yaoddmuse.el")

;; terminal multiplexer
(install-elisp "https://raw.github.com/m2ym/emux-el/master/emux.el")

;; switch-window visualy
(install-elisp "https://raw.github.com/dimitri/switch-window/master/switch-window.el")

;; for source code reading
(install-elisp "https://raw.github.com/takaishi/succor/master/succor.el")

;; indirect region
(install-elisp "https://raw.github.com/renard/indirect-region/master/indirect-region.el")

;; wrap-region
(install-elisp "https://raw.github.com/rejeep/wrap-region/master/wrap-region.el")

;; rust-mode
(install-elisp "https://raw.github.com/marijnh/rust-mode/master/cm-mode.el")
(install-elisp "https://raw.github.com/marijnh/rust-mode/master/rust-mode.el")
