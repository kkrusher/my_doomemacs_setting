;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)


;;(package! org-roam)

;; pinned version of org mode have bugs
(unpin! org)
(package! org-web-tools)
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))
(package! org-modern)
(package! org-anki
  :recipe (:host github
           :repo "eyeinsky/org-anki"
           :files ("*.el")))
(package! org-fc
  :recipe (:host github
           :repo "l3kn/org-fc"
           :files (:defaults "awk" "demo.org")))
;; 如果想要开发调试这包，应该将/org-fc源代码clone到.config/doom/lisp/下，然后如下配置
;; (package! org-fc
;;   :recipe (:local-repo "lisp/org-fc"
;;            :build (:not compile)
;;            :files (:defaults "awk" "demo.org")))
(package! alert)
(package! org-alert)
(package! org-wild-notifier)



(when NOT-ANDROID
  (package! ivy-bibtex)
  (package! org-fragtog)
  ;; (package! ox-beamer)
  ;; (package! async)
  (package! org-roam)
  (package! org-ref)
  (package! org-roam-ui)
  (package! org-roam-bibtex)
  (package! org-noter  :recipe
    (:host github
     :repo "dmitrym0/org-noter-plus"
     :branch "master"
     :files ("*.el" "modules/*.el" "other/*.el")  ;; include modules and auxiliaries
     )))
(unless NOT-ANDROID
  (package! ivy-bibtex :disable t)
  (package! org-fragtog :disable t)
  ;; (package! ox-latex-async :disable t)
  (package! org-roam :disable t)
  (package! org-ref :disable t)
  (package! org-roam-ui :disable t)
  (package! org-roam-bibtex :disable t)
  (package! org-noter :disable t)
  )

(package! ebdb)
(package! sis
  :recipe (:host github
           :repo "laishulu/emacs-smart-input-source"
           :files ("*.el")))

;; https://github.com/doomemacs/doomemacs/blob/master/docs/getting_started.org#changing-a-recipe-for-an-included-package
;; If a Doom module installs package X from one place, but you’d like to install it from another (say, a superior fork),
;; add a package! declaration for it in your DOOMDIR/packages.el. Your private declarations always have precedence over modules (even your own).
;; pyim 在chinese模块中已经加载了
(package! pyim
  :recipe (:host github
           :repo "tumashu/pyim"
           :files ("*.el")))
(package! pyim-basedict
  :recipe (:host github
           :repo "tumashu/pyim-basedict"
           :files ("*")))
(package! highlight-parentheses)

(package! golden-ratio)
