;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; qwwerasfafq
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jinkai Tian"
      user-mail-address "tianjinkai13@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;

(setq doom-font (font-spec :family "Iosevka SS09" :size (cond (NOT-ANDROID 20)
                                                              (IS-ANDROID 40)
                                                              (t 20))  :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size (cond (NOT-ANDROID 20)
                                                                             (IS-ANDROID 40)
                                                                             (t 20))))

;; (setq doom-font (font-spec :family "Iosevka SS09" :size 20 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size 13))
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-nord-light)
;;(setq doom-theme 'doom-flatwhite)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")



;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(cond
 ;; macOS 系统
 (NOT-ANDROID
  (setq user-directory "/Users/k/")
  ;; (setq user-directory "/home/k/")
  (setq org-directory (concat user-directory "my_org-files/"))
  (setq +jk/doom-directory (concat user-directory ".config/doom/")))

 ;; Android 系统 (android native emacs而不是termux中的)
 (IS-ANDROID
  (string-equal system-type "android")
  (setq user-directory "/data/data/org.gnu.emacs/files/")
  (setq org-directory "/sdcard/p9fqy-76ejy")
  (setq +jk/doom-directory (concat user-directory ".doom.d/"))))

(setq +jk/doom-config-el (concat +jk/doom-directory "/config.el"))
(setq +jk/doom-config-org (concat org-directory "/resources/config.org"))

(setq +jk/agenda-directory org-directory)
(setq +jk/org-capture-inbox-file (concat org-directory "/agenda/inbox.org"))

(setq +jk/org-roam-directory org-directory )
(setq +jk/resources-directory (concat org-directory "/resources/"))
(setq +jk/bibtex-file (concat +jk/resources-directory "/MyLibrary.bib"))
(setq +jk/paper-notes-directory (concat +jk/org-roam-directory "paper_notes/"))

;; solve the problem of 'Cmd-x raise M-x rather than cut' problem
;; https://github.com/doomemacs/doomemacs/issues/3860
(defun cut-region (beg end)
  "Copies the text to the kill buffer and deletes the selected region."
  (interactive "r")
  (copy-region-as-kill beg end)
  (delete-region beg end))
(map! "s-x" #'cut-region)

;; 通过启用 visual-line-mode 来实现到达屏幕边缘时自动换行。visual-line-mode 是一个 minor mode，它会根据窗口大小而不是固定的列数来换行。
(when IS-ANDROID
  (add-hook! 'text-mode-hook #'visual-line-mode))

;; 在 text-mode-hook 中添加调试代码，每当进入 Text mode 时，都会在 Emacs 的 *Messages* 缓冲区中打印一条消息，表明该钩子已被执行。
;; (add-hook 'text-mode-hook
;;           (lambda ()
;;             (message "text-mode-hook executed")))

;; maximize the window on initialization
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; add scroll bar
(scroll-bar-mode 1)

;; disable confirm exit
(setq confirm-kill-emacs nil)

;; to support select and move by mouse
(setq mouse-drag-and-drop-region t)

;; auto-save-mode is somewhat a backup in temporary file named #<file_name>#, auto-save-visited-mode is actually auto save on related file
(auto-save-visited-mode +1)

;; load sessions from last leave
;; cuurently have bugs, use "SPC q L" instead
;; (add-hook! 'window-setup-hook #'doom/quickload-session)


(add-hook 'emacs-startup-hook
          (lambda ()
            (find-file (concat org-directory "/agenda/inbox.org"))
            (delete-other-windows)))


;; 在所有可编辑模式下自动进入 insert 模式，你可以使用 derived-mode-p 函数来检查当前模式是否派生自 text-mode 或其他可编辑模式。
;; find-file-hook 钩子在每次打开一个新文件时触发
(add-hook 'find-file-hook
          (lambda ()
            (when (or (derived-mode-p 'text-mode)
                      (derived-mode-p 'prog-mode))
              (evil-insert-state))))

;; set undo
(when NOT-ANDROID
  (global-set-key (kbd "C-z") 'undo))

(map!
 :g "s-w"       #'kill-this-buffe
 :g "s-["       #'previous-buffer
 :g "s-]"       #'next-buffer
 )

;;  SPC f f 默认搜索当前buffer所在的目录，这里更改成搜索当前buffer所在的project
(map! :leader
      :desc "Find file in project" "f f" #'projectile-find-file)


;; 设置打开常用的文档的快捷键
(map! :leader
      :desc "Open inbox.org" "o 1" #'(lambda ()
                                       (interactive)
                                       (find-file (concat org-directory "/agenda/inbox.org")))
      :desc "Open resources/config.org" "o 2" #'(lambda ()
                                                  (interactive)
                                                  (find-file (concat org-directory "/resources/config.org")))
      :desc "Open doom/init.el" "o 3" #'(lambda ()
                                          (interactive)
                                          (find-file (concat +jk/doom-directory "/init.el")))
      :desc "Open doom/packages.el" "o 4" #'(lambda ()
                                              (interactive)
                                              (find-file (concat +jk/doom-directory "/packages.el")))
      )

;; 打开默认md文件
(defun open-default-markdown-file ()
  "Open a specific Markdown file."
  (interactive)
  (find-file (concat +jk/resources-directory "/md2org.md"))
  ;; 直接进入insert mode
  (evil-insert-state)
  )

(map! :leader
      :desc "Open default markdown file" "o m" #'open-default-markdown-file)

(setq doom-leader-key "S-SPC"
      doom-localleader-key "S-SPC m"
      doom-leader-alt-key "S-SPC"
      doom-localleader-alt-key "S-SPC m")

;; open "M-x" by "M-SPC M-SPC"
(map! :leader
      :desc "Open like spacemacs" "S-SPC" #'execute-extended-command)

;; Kicked out of insert mode when typing 'fd' quickly
;; https://github.com/doomemacs/doomemacs/issues/1946
(after! evil-escape
  (setq-default evil-escape-key-sequence "fd"))

;; https://github.com/doomemacs/doomemacs/issues/3108
(after! gcmh
  (setq gcmh-high-cons-threshold 33554432))

(after! org
  (setq word-wrap-by-category t)
  )

;; 设置中文字体。 测试： 将 直 言 判
;; https://emacs-china.org/t/doom-emacs/23513/8
(defun my-cjk-font()
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font t charset (font-spec :family "STKaiti")))
  ;; 单独设置 symbol 字符集的字体
  (set-fontset-font t 'symbol (font-spec :family "STKaiti")))

(add-hook 'after-setting-font-hook #'my-cjk-font)

(setq org-emphasis-regexp-components
      '("-[:multibyte:][:space:]('\"{"
        "-[:multibyte:][:space:].,:!?;'\")}\\["
        "[:space:]"
        "."
        1))
(after! org
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (org-element-update-syntax)
  )

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (and NOT-ANDROID
             (string-equal (buffer-file-name)
                           (expand-file-name +jk/doom-config-org)))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(after! treemacs
  ;;(map! "<f11>" #'treemacs)
  ;; add a key binding to treemacs select window
  (map! :leader
        "w p" #'treemacs-select-window)

  ;; (setq treemacs-sorting 'mod-time-desc)
  (setq treemacs-sorting ' alphabetic-asc)

  (setq treemacs-tag-follow-mode t)
  ;; Dotfiles will be shown if this is set to t and be hidden otherwise.
  (setq treemacs-show-hidden-files nil)
  )

;; start treemacs on emacs startup
;; (add-hook! 'window-setup-hook #'treemacs 'append)

(when NOT-ANDROID
  (add-hook! 'window-setup-hook #'treemacs))

(after! org

  ;; 该功能允许在创建到 Org 文件或标题的链接时自动使用 ID。这意味着当你在 Org mode 中创建到另一个 Org 文件或某个特定标题的链接时，会自动生成并使用一个唯一 ID 作为链接的目标，而不是使用文件名和标题。
  (setq org-id-link-to-org-use-id t)
  ;; replaced by snippets
  ;; add an option to 'C-c C-,' for new template
  ;; (add-to-list 'org-structure-template-alist '("R" . "src R"))
  ;; (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  ;; (add-to-list 'org-structure-template-alist '("py" . "src python"))
  ;; (add-to-list 'org-structure-template-alist '("" . "src json"))

  ;; 添加一个设置来确保每次打开 Org 文件时都启用内嵌图片的显示
  ;; 无需每个文件单独设置 #+STARTUP: inlineimages
  ;; 但是打开这个选项，当attachment中有除了图片以为的附件时，显示会出问题
  ;; (setq org-startup-with-inline-images t)

  )

(after! org
  (setq org-file-apps
        '((remote . emacs)
          (system . "open %s")
          ("ps.gz" . "gv %s")
          ("eps.gz" . "gv %s")
          ("dvi" . "xdvi %s")
          ("fig" . "xfig %s")
          (t . "open %s")))
  ;;  (setq org-file-apps org-file-apps-macosx)
  )

(after! org-download
  ;; doom 设置的默认值为"_%Y%m%d_%H%M%S"
  (setq org-download-timestamp "_%Y%m%d_")
  )

(with-eval-after-load 'org
  (remove-hook 'org-tab-first-hook #'+org-indent-maybe-h)
  )

(after! org
  ;; when archive a subtree with inherited tags, add the inherited tags to the subtree after archive
  (setq org-archive-subtree-add-inherited-tags t)

  ;; Information to record when a task is refiled.
  ;; (setq org-log-refile 'time)

  ;; default value of org-refile-targets is
  ;; ((nil :maxlevel . 3)
  ;;  (org-agenda-files :maxlevel . 3))
  ;;  but I want all org files in org-directory
  (setq org-refile-targets `(
                             (nil :maxlevel . 1)
                             (org-agenda-files :maxlevel . 1)
                             (,(directory-files-recursively org-directory "^[a-z0-9]*.org$") :maxlevel . 1)
                             (,(directory-files-recursively +jk/doom-directory "^[a-z0-9]*.org$") :maxlevel . 1)
                             ))

  (setq org-reverse-note-order t)
  )

(after! org
  ;; (setq org-todo-keywords
  ;;       '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s!)" "WAIT(w@/!)" "HOLD(h)" "IDEA(i)" "|" "DONE(d!)" "KILL(k@)")
  ;;         (sequence "[ ](T)" "[-](N)" "[?](W@/!)" "|" "[X](D!)")
  ;;         (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))
  ;;       )
  (setq org-todo-keywords
        '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "NEXT(n)" "WAIT(w@/!)" "HOLD(h)" "IDEA(i)" "|" "DONE(d!)" "KILL(k@)")
          )
        )
  )

(after! org
  ;; https://emacs.stackexchange.com/questions/29152/how-to-use-global-tags-list-when-tagging-text-files-with-org-mode-and-helm
  ;; 设置补全时显示所有agenda文件中的tag
  (setq org-complete-tags-always-offer-all-agenda-tags t)

  ;;default tag list
  (setq org-tag-persistent-alist '(("@work" . ?w)
                                   ("@home" . ?h)
                                   ("emacs" . ?E)
                                   ("python" . ?P)
                                   ("shell". ?S)
                                   ("LLM")
                                   ("zotero")
                                   ))
  )

(after! org
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file +jk/org-capture-inbox-file)
           "* TODO %u %? \n %i" :prepend t :empty-lines-after 2)
          ("r" "To be read" entry
           (file +jk/org-capture-inbox-file)
           "* TODO %u Paper title: %?\n %i \n" :prepend t :empty-lines-after 2)
          ("i" "Interrupted" entry
           (file +jk/org-capture-inbox-file)
           "* TODO %u %? \n %i" :prepend t :clock-in t :clock-resume t :empty-lines-after 2)
          ))
  ;; (setq org-tab-first-hook '(+org-yas-expand-maybe-h
  ;;                          org-babel-hide-result-toggle-maybe
  ;;                          org-babel-header-arg-expand
  ;;                          +org-clear-babel-results-h
  ;;                          +org-cycle-only-current-subtree-h)'
  ;;        )

  )

(after! org
  ;; (setq org-agenda-files (list +jk/agenda-directory))
  ;; (setq org-agenda-files (directory-files-recursively +jk/agenda-directory "org$"))
  (setq org-agenda-files (directory-files-recursively org-directory "org$"))
  ;; "org$"是用来匹配文件名以"org"结尾的正则表达式，即查找所有Org文件（.org扩展名）

  (map! "<f1>" #'org-agenda)

  ;; The initial value of follow mode in a newly created agenda window.
  ;; evil 开启的情况下，只有使用jk作为方向键换行的时候才会跟随，使用方向键不会跟随
  (setq org-agenda-start-with-follow-mode t)

  ;; (setq org-stuck-projects '("+TODO=\"PROJ\"/-DONE" ("NEXT" "[-]") nil ""))
  (setq org-stuck-projects '("/-DONE" ("NEXT" "[-]") nil ""))
  (setq org-agenda-custom-commands
        '(
          ("w" "Tasks waiting for someone"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "👂 Tasks waiting for someone:\n")))))


          ("W" "Agendas for the past 7 days"
           ((agenda "Past 7 days"
                    ((org-agenda-overriding-header "Agendas for the past 7 days:\n")
                     (org-agenda-start-day "-7d")
                     (org-agenda-span 7)))))

          ;; ("c" "Custom view"
          ;;  ((agenda ""
          ;;         ((org-agenda-overriding-header "今日未完成的项目")
          ;;          (org-agenda-start-day "+0d")
          ;;          (org-agenda-span 'day)
          ;;          (org-agenda-skip-function
          ;;           '(org-agenda-skip-entry-if 'todo 'done))))
          ;;   (todo "TODO"
          ;;       ((org-agenda-overriding-header "所有未完成的项目")
          ;;        (org-agenda-skip-function
          ;;         '(org-agenda-skip-if nil '(scheduled deadline)))))))

          ("u" "Unscheduled TODO" todo "TODO"
           ((org-agenda-todo-ignore-scheduled 'all)
            (org-agenda-todo-ignore-deadlines 'all)
            (org-agenda-todo-ignore-with-date 'all)
            (org-agenda-sorting-strategy
             '(category-keep))))


          ("A" "Daily agenda and top priority tasks"
           ((tags-todo "*"
                       ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                        (org-agenda-skip-function
                         `(org-agenda-skip-entry-if
                           'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                        (org-agenda-block-separator nil)
                        (org-agenda-overriding-header "Important tasks without a date:\n")))
            (agenda "" ((org-agenda-start-day "+0d")
                        (org-agenda-span 1)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator ?*)
                        (org-scheduled-past-days 100000) ;; 显示过去100000天（所有）的计划
                        ;; We don't need the `org-agenda-date-today'
                        ;; highlight because that only has a practical
                        ;; utility in multi-day views.
                        (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                        (org-agenda-format-date "%A %-e %B %Y")
                        (org-agenda-overriding-header "Today's agenda:\n")))
            (agenda "" ((org-agenda-start-on-weekday nil)
                        (org-agenda-start-day "+1d")
                        (org-agenda-span 3)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator ?*)
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                        (org-agenda-overriding-header "Next three days:\n")))
            (agenda "" ((org-agenda-time-grid nil)
                        (org-agenda-start-on-weekday nil)
                        ;; We don't want to replicate the previous section's
                        ;; three days, so we start counting from the day after.
                        (org-agenda-start-day "+4d")
                        (org-agenda-span 14)
                        (org-agenda-show-all-dates ?*)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator ?*)
                        ;; (org-agenda-entry-types '(:deadline))
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                        ;; (org-agenda-overriding-header "Upcoming deadlines (+14d):")))))
                        (org-agenda-overriding-header "Upcoming +14d:")))))

          ))

  ;; 打开emacs 显示自定义的agenda view
  ;; (add-hook 'emacs-startup-hook
  ;;           (lambda ()
  ;;             (org-agenda nil "A")
  ;;             (delete-other-windows)))

  ;; 设置agenda自动显示时间统计报告
  (setq org-agenda-start-with-clockreport-mode t)

  ;; 设置org-agenda-clockreport-mode
  (setq org-agenda-clockreport-parameter-plist '(:scope agenda-with-archives :stepskip0 t :link t :maxlevel 3 :fileskip0 t :formula % :hidefiles t))

  )

(when NOT-ANDROID  ; Check if the system is Mac
  (after! org-roam
    (setq org-roam-directory org-directory)
    (setq org-roam-index-file (concat +jk/org-roam-directory "index.org"))
    ;; 使org agenda显示.org_archive文件中的todo entry
    (setq org-agenda-archives-mode t)
    )

  (use-package! org-roam-ui
    :after org-roam
    ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
    ;;         a hookable mode anymore, you're advised to pick something yourself
    ;;         if you don't care about startup time, use
    ;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
  )

(when NOT-ANDROID  ; Check if the system is Mac
  (use-package! org-roam-bibtex
    :after (org-roam)
    :init
    (setq org-roam-capture-templates
          '(("d" "default" plain "\n%?"
             :target
             (file+head "${slug}.org" "#+title: ${title}\n#+date: %U\n")
             :unnarrowed t)
            ("c" "contact" plain "\n%?"
             :target
             (file+head "contact/${slug}.org" "#+title: ${title}\n")
             :unnarrowed t)
            ("r" "bibliography reference" plain
             "Published by %^{author} in %^{year}.\n\n%?"
             :target
             (file+head "paper_notes/${citekey}.org" "#+title: ${title}\n#+date: %U\n")
             :unnarrowed t)
            ))
    :hook (org-roam-mode . org-roam-bibtex-mode)
    :custom
    (orb-insert-interface  "ivy-bibtex")
    :config
    (setq orb-roam-ref-format 'org-ref-v3)
    (setq orb-insert-link-description 'citation-org-ref-3)
    (setq orb-preformat-keywords '("citekey" "author" "year"))
    )

  (map! :leader
        "m m l" #'orb-insert-link)
  )

(when NOT-ANDROID  ; Check if the system is Mac
  (setq +jk/onedrive-directory (concat user-directory  "OneDrive - nudt.edu.cn/"))
  (setq +jk/bibtex-pdf-file-directory (concat +jk/onedrive-directory "/Zotero/"))

  ;; from org-ref manual
  (use-package! ivy-bibtex ;;
    :init                 ;;
    (setq bibtex-completion-bibliography (list +jk/bibtex-file) ;;
          ;; If the BibTeX entries have a field that specifies the full path to the PDFs, that field can also be used. For example, JabRef and Zotero store the location of PDFs in a field called File:
          bibtex-completion-pdf-field "file"
          bibtex-completion-library-path (list +jk/bibtex-pdf-file-directory)
          bibtex-completion-notes-path +jk/paper-notes-directory
          bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

          bibtex-completion-additional-search-fields '(keywords)
          bibtex-completion-display-formats
          '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
            (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
            (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
            (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
            (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
          bibtex-completion-pdf-open-function
          (lambda (fpath)
            (call-process "open" nil 0 nil fpath))))

  (use-package! org-ref
    :init
    (require 'bibtex)
    (setq bibtex-autokey-year-length 4
          bibtex-autokey-name-year-separator "-"
          ;;
          bibtex-autokey-year-title-separator "-"
          ;;
          bibtex-autokey-titleword-separator "-"
          ;;
          bibtex-autokey-titlewords 2
          ;;
          bibtex-autokey-titlewords-stretch 1
          ;;
          bibtex-autokey-titleword-length 5)
    (require 'org-ref-ivy)
    (require 'org-ref-arxiv)
    (require 'org-ref-scopus)
    (require 'org-ref-wos))

  (use-package! org-ref-ivy
    :init (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
                org-ref-insert-cite-function 'org-ref-cite-insert-ivy
                org-ref-insert-label-function 'org-ref-insert-label-link
                org-ref-insert-ref-function 'org-ref-insert-ref-link
                org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body))))
  )

(when NOT-ANDROID  ; Check if the system is Mac
  (use-package! org-noter
    ;; sequence should be respected as in org-pdftools description: org-noter then org-pdftools then org-noter-pdftools
    :after org-roam
    ;;:hook (org-roam . org-noter-mode)
    ;;:init
    :bind ("C-c n n" . org-noter)
    :custom
    ;; (setq org-noter-notes-window-location vertical-split) ; optional horizontal/vertical split
    (org-noter-highlight-selected-text t)
    :config
    ;; Explictly load required modules
    (require 'org-noter-pdf)
    (require 'org-noter-dynamic-block)
    ;; Your org-noter config...
    (setq org-noter-notes-search-path '(+jk/paper-notes-directory)) ; optional
    ;;(setq org-noter-default-notes-file-names '("Notes.org"))
    ;;(setq org-noter-separate-notes-from-heading t)
    ;; optional if nil it will turn off adding org-ids to notes so not to be cached with other org-roam nodes
    (setq org-noter-pdftools-use-org-id nil)
    (setq org-noter-max-short-selected-text-length 700000)
    ;; (define-advice org-noter--insert-heading (:after (level title &optional newlines-number location) add-full-body-quote)
    ;;   "Advice for org-noter--insert-heading.  When inserting a precise note insert the text of the note in the body as an org mode QUOTE block. =org-noter-max-short-length= should be set to a large value to short circuit the normal behavior:  =(setq org-noter-max-short-selected-text-length 80000)="
    ;;   ;; this tells us it's a precise note that's being invoked.
    ;;   (if (consp location)
    ;;       (insert (format "#+BEGIN_QUOTE\n%s\n#+END_QUOTE" title))))
    )
  )

(when NOT-ANDROID
(after! org
  (setq org-startup-with-latex-preview t) ; 默认启用LaTeX预览
  (add-to-list 'org-latex-packages-alist '("" "tcolorbox" t))
  (add-to-list 'org-latex-packages-alist '("" "amsmath" t))
  (add-to-list 'org-latex-packages-alist '("" "amsfonts" t))
  (add-to-list 'org-latex-packages-alist '("" "bm" t))
  (add-to-list 'org-latex-packages-alist '("" "hyperref" t))
  (add-to-list 'org-latex-packages-alist '("" "verbatim" t))
  (add-to-list 'org-latex-packages-alist '("" "array" t))
  (add-to-list 'org-latex-packages-alist '("" "float" t))
  (add-to-list 'org-latex-packages-alist '("" "makecell" t))
  (add-to-list 'org-latex-packages-alist '("" "mathtools" t))
  (add-to-list 'org-latex-packages-alist '("" "braket" t))
  (add-to-list 'org-latex-packages-alist '("" "url" t))
  (add-to-list 'org-latex-packages-alist '("" "subfig" t))
  )
    )

;;Org mode supports inline image previews of LaTeX fragments. These can be toggled with C-c C-x C-l. org-fragtog automates this, so fragment previews are disabled for editing when your cursor steps onto them, and re-enabled when the cursor leaves.
(use-package! org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode))

(defun send-notification (title message)
  "Send a macOS notification if on a macOS system."
  (when (eq system-type 'darwin)
    (let ((script (format "display notification \"%s\" with title \"%s\""
                          message title)))
      (start-process "osascript-send-notification" nil "osascript" "-e" script))))

;; test
;; (send-notification "Pomodoro Complete" "Take a break!")


(use-package! org-pomodoro
  :after org
  :config
  (setq
   org-pomodoro-length 25
   org-pomodoro-short-break-length 5
   ;; 完成一个时间段后，是否需要人为停止。如果设置了 org-pomodoro-manual-break为true，需要手动运行 org-pomodoro 结束当前周期，进入休息阶段
   ;; org-pomodoro-manual-break t
   org-pomodoro-keep-killed-pomodoro-time t

   ;; 下载华为提示音: https://sc.chinaz.com/yinxiao/161008432362.htm
   ;; 配置提示音频为 pomodoro 的提示音
   org-pomodoro-start-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-finished-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-overtime-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-short-break-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-long-break-sound (concat +jk/resources-directory "/huawei.wav")
   )
  (add-hook 'org-pomodoro-finished-hook
            (lambda ()
              (send-notification "Pomodoro Complete" "Take a break!")))
  (add-hook 'org-pomodoro-short-break-finished-hook
            (lambda ()
              (send-notification "Pomodoro Complete" "Short break is finished!")))
  (add-hook 'org-pomodoro-long-break-finished-hook
            (lambda ()
              (send-notification "Pomodoro Complete" "Long break is finished!")))
  )

;; be careful
;; maybe not work and have side effects
;; https://github.com/emacs-evil/evil/issues/1623
(advice-remove 'set-window-buffer #'ad-Advice-set-window-buffer)

(after! org
  (setq org-hide-emphasis-markers t))
(after! org-appear
  (setq org-appear-autolinks t ))

(use-package! org-pandoc-import :after org)

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        org-modern-todo-faces
        '(("TODO" :inverse-video t :inherit org-todo)
          ("PROJ" :inverse-video t :inherit +org-todo-project)
          ("STRT" :inverse-video t :inherit +org-todo-active)
          ("[-]"  :inverse-video t :inherit +org-todo-active)
          ("HOLD" :inverse-video t :inherit +org-todo-onhold)
          ("WAIT" :inverse-video t :inherit +org-todo-onhold)
          ("[?]"  :inverse-video t :inherit +org-todo-onhold)
          ("KILL" :inverse-video t :inherit +org-todo-cancel)
          ("NO"   :inverse-video t :inherit +org-todo-cancel))
        org-modern-footnote
        (cons nil (cadr org-script-display))
        org-modern-block-fringe nil
        org-modern-block-name
        '((t . t)
          ("src" "»" "«")
          ("example" "»–" "–«")
          ("quote" "❝" "❞")
          ("export" "⏩" "⏪"))
        org-modern-progress nil
        org-modern-priority nil
        org-modern-horizontal-rule (make-string 36 ?─)
        ;; org-modern-keyword
        ;; '((t . t)
        ;;   ("title" . "𝙏")
        ;;   ("subtitle" . "𝙩")
        ;;   ("author" . "𝘼")
        ;; ("email" . #("" 0 1 (display (raise -0.14))))
        ;; ("date" . "𝘿")
        ;; ("property" . "☸")
        ;; ("options" . "⌥")
        ;; ("startup" . "⏻")
        ;; ("macro" . "𝓜")
        ;; ("bind" . #("" 0 1 (display (raise -0.1))))
        ;; ("bibliography" . "")
        ;; ("print_bibliography" . #("" 0 1 (display (raise -0.1))))
        ;; ("cite_export" . "⮭")
        ;; ("print_glossary" . #("ᴬᶻ" 0 1 (display (raise -0.1))))
        ;; ("glossary_sources" . #("" 0 1 (display (raise -0.14))))
        ;; ("include" . "⇤")
        ;; ("setupfile" . "⇚")
        ;; ("html_head" . "🅷")
        ;; ("html" . "🅗")
        ;; ("latex_class" . "🄻")
        ;; ("latex_class_options" . #("🄻" 1 2 (display (raise -0.14))))
        ;; ("latex_header" . "🅻")
        ;; ("latex_header_extra" . "🅻⁺")
        ;; ("latex" . "🅛")
        ;; ("beamer_theme" . "🄱")
        ;; ("beamer_color_theme" . #("🄱" 1 2 (display (raise -0.12))))
        ;; ("beamer_font_theme" . "🄱𝐀")
        ;; ("beamer_header" . "🅱")
        ;; ("beamer" . "🅑")
        ;; ("attr_latex" . "🄛")
        ;; ("attr_html" . "🄗")
        ;; ("attr_org" . "⒪")
        ;; ("call" . #("" 0 1 (display (raise -0.15))))
        ;; ("name" . "⁍")
        ;; ("header" . "›")
        ;; ("caption" . "☰")
        ;; ("results" . "🠶")
        ;; )
        )
  (custom-set-faces! '(org-modern-statistics :inherit org-checkbox-statistics-todo)))

(after! org
  (customize-set-variable 'org-anki-default-deck "my-target-deck"))

(use-package! org-fc
  :after org
  :config
  (require 'org-fc-keymap-hint)
  (require 'org-fc-hydra)
  (setq org-fc-directories `(,org-directory))
  (map! :leader
        (:prefix ("l" . "learning")
         :desc "Review flash cards." "r" 'org-fc-review
         :desc "Open a buffer showing the dashboard view." "d" 'org-fc-dashboard
         (:prefix ("c" . "create")
          :desc "Create a normal card." "n" 'org-fc-type-normal-init
          :desc "Create a cloze card." "c" 'org-fc-type-cloze-init))))

(defun dc/alert-android-notifications-notify (info)
  "Send notifications using `android-notifications-notify'.
`android-notifications-notify' is a built-in function in the native Emacs
Android port."
  (let ((title (or (plist-get info :title) "Android Notifications Alert"))
        (body (or (plist-get info :message) ""))
        (urgency (cdr (assq (plist-get info :severity)
                            alert-notifications-priorities)))
        (icon (or (plist-get info :icon) alert-default-icon))
        (replaces-id (gethash (plist-get info :id) alert-notifications-ids)))
    (android-notifications-notify
     :title title
     :body body
     :urgency urgency
     :icon icon
     :replaces-id replaces-id)))



;; https://github.com/jwiegley/alert
(use-package! alert
   :config
  ;;  (setq alert-default-style 'osx-notifier)
   (alert-define-style 'android-notifications :title "Android Notifications"
                    :notifier #'dc/alert-android-notifications-notify)
   )

(use-package! org-alert
  :after (org alert)
  :custom
  ;; Use different backends depending on the platform
  (alert-default-style (if (eq system-type 'android)
                           'android-notifications
                         'osx-notifier))
  :config
  ;; Setup timing
  (setq org-alert-interval 30  ;; a timer which periodically calls org-alert-check (defaults to 300s).
        org-alert-notify-cutoff 10 ;; controls how long before a scheduled event a notification should be sent (defaults to 10minutes).
        org-alert-notify-after-event-cutoff 10 ;; controls how long after a scheduled event to continue sending notifications (defaults to 10minutes).
        )

  ;; Setup notification title (if using 'custom)
  (setq org-alert-notification-title "Org Alert Reminder")

  ;; Use non-greedy regular expression
  (setq org-alert-time-match-string
        "\\(?:SCHEDULED\\|DEADLINE\\):.*?<.*?\\([0-9]\\{2\\}:[0-9]\\{2\\}\\).*>")

  ;; Enable org-alert
  ;; 在配置中打开org-alert会导致org mode文件渲染的问题，应该是和org-modern等用来美化org mode的包不兼容
  ;; 如果需要的话，尝试手动打开
  ;; (org-alert-enable)
  )
