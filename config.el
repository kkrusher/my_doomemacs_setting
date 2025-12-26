;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
                                                              (t 20)) :weight 'semi-light))

;; (setq doom-font (font-spec :family "Iosevka SS09" :size (cond (NOT-ANDROID 30)
;;                                                               (IS-ANDROID 40)
;;                                                               (t 20)))
;;       doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size (cond (NOT-ANDROID 30)
;;                                                                             (IS-ANDROID 40)
;;                                                                             (t 20))))

;; (setq doom-font (font-spec :family "Iosevka SS09" :size (cond (NOT-ANDROID 30)
;;                                                               (IS-ANDROID 40)
;;                                                               (t 20)))
;;       doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size (cond (NOT-ANDROID 30)
;;                                                                             (IS-ANDROID 40)
;;                                                                             (t 20))))


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

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)


;; maximize the window on initialization
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; add scroll bar
(scroll-bar-mode 1)

;; disable confirm exit
(setq confirm-kill-emacs nil)

;; to support select and move by mouse
(setq mouse-drag-and-drop-region t)

;; auto-save-mode is somewhat a backup in temporary file named #<file_name>#, auto-save-visited-mode is actually auto save on related file
;; (auto-save-visited-mode +1)

;; load sessions from last leave
;; cuurently have bugs, use "SPC q L" instead
;; (add-hook! 'window-setup-hook #'doom/quickload-session)

;; 启动 emacs 时自动进入 inbox.org
(add-hook 'emacs-startup-hook
          (lambda ()
            (find-file (concat org-directory "/agenda/inbox.org"))
            (delete-other-windows)))


;; 在所有可编辑模式下自动进入 insert 模式，你可以使用 derived-mode-p 函数来检查当前模式是否派生自 text-mode 或其他可编辑模式。
;; find-file-hook 钩子在每次打开一个新文件时触发
;; (add-hook 'find-file-hook
;;           (lambda ()
;;             (when (or (derived-mode-p 'text-mode)
;;                       (derived-mode-p 'prog-mode))
;;               (evil-insert-state))))
(defun my-enter-evil-insert-state ()
  (when (or (derived-mode-p 'text-mode)
            (derived-mode-p 'prog-mode)
            (derived-mode-p 'org-mode)
            (derived-mode-p 'org-agenda-mode))  ; 添加 org-agenda-mode
    (evil-insert-state)))

(add-hook 'find-file-hook #'my-enter-evil-insert-state)
(add-hook 'org-agenda-mode-hook #'my-enter-evil-insert-state)

(cond
 ;; macOS 系统
 ((eq system-type 'darwin)
  (setq user-directory "/Users/k/")
  (setq org-directory (concat user-directory "my-org-files/"))
  (setq +jk/doom-directory (concat user-directory ".config/doom/")))

 ;; Linux 系统
 ((eq system-type 'gnu/linux)
  (setq user-directory "/home/k/")
  (setq org-directory (concat user-directory "my-org-files/"))
  (setq +jk/doom-directory (concat user-directory ".config/doom/")))

 ;; Android 系统 (android native emacs 而不是 termux 中的)
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

(defun +jk/convert-markdown-to-org-in-clipboard-and-insert ()
  "Convert Markdown text in clipboard to Org format using pandoc and insert it at point."
  (interactive)
  ;; pbpaste 仅适用于macos，如果使用别的系统还需要重新调整
  ;; 使用pbpaste显示中文乱码
  ;; (let ((markdown-text (shell-command-to-string "LC_CTYPE=UTF-8 pbpaste"))
        ;; 使用gui-get-selection在更新emacs29后会报错，目前没有debug
  ;; (let ((markdown-text (gui-get-selection 'CLIPBOARD))
  (let ((markdown-text (shell-command-to-string "osascript -e 'get the clipboard'"))
        (lua-filter-path (concat +jk/doom-directory "remove_custom_id.lua")))
    (message "Pan")
    (message "%s" markdown-text)

    ;; AppleScript 会将文本中的换行符转换为 ASCII 字符 \r（回车符），而不是 \n（换行符）。这会导致在 Emacs 中显示时换行符丢失。
    ;; Replace \r with \n
    (setq markdown-text (replace-regexp-in-string "\r" "\n" markdown-text))
    (with-temp-buffer
      (set-buffer-multibyte t)  ; 确保缓冲区支持多字节字符
      (insert markdown-text)
      ;; 在命令行中添加 --wrap=none 选项可以告诉 Pandoc 不要自动换
      ;; 使用自定义的 Pandoc Lua 过滤器来移除 :CUSTOM_ID: 标签
      (message "Pandoc command: %s" (format "pandoc -f markdown -t org --wrap=none --lua-filter=%s" lua-filter-path))
      (shell-command-on-region (point-min) (point-max) (format "pandoc -f markdown -t org --wrap=none --lua-filter=%s" lua-filter-path) (current-buffer) t)
      ;; 打印临时缓冲区的内容以进行调试
      ;; (message "Converted Org text: %s" (buffer-string))
      (setq org-text (buffer-string))
      )
    ;; 插入转换后的文本到当前光标处
    (insert org-text)
    ;; ;; 删除多余的换行符（如果存在）
    ;; (unless (eobp)
    ;; (delete-char -1))
    ))

(defun +jk/convert-clipboard-to-format-and-insert (format)
  "Convert text in clipboard to a specified FORMAT using pandoc and insert it at point. FORMAT should be either 'org' or 'latex'."
  (interactive "sFormat (org/latex): ")
  (let ((markdown-text (shell-command-to-string "osascript -e 'get the clipboard'"))
        (lua-filter-path (concat +jk/doom-directory "remove_custom_id.lua"))
        (target-format (cond ((string= format "org") "org")
                             ((string= format "latex") "latex")
                             (t (error "Invalid format specified"))))
        org-text)
    (setq markdown-text (replace-regexp-in-string "\r" "\n" markdown-text))
    (with-temp-buffer
      (set-buffer-multibyte t)
      (insert markdown-text)
      (shell-command-on-region (point-min) (point-max)
                               (format "pandoc -f markdown -t %s --wrap=none --lua-filter=%s" target-format lua-filter-path)
                               (current-buffer) t)
      (setq org-text (buffer-string)))
    (insert org-text)))

(map! :leader
      :desc "Convert clipboard to Org (from Markdown)" "a p o" #'(lambda () (interactive) (+jk/convert-clipboard-to-format-and-insert "org"))
      :desc "Convert clipboard to Latex (from Markdown)"   "a p l" #'(lambda () (interactive) (+jk/convert-clipboard-to-format-and-insert "latex")))

;; (map! :leader
;;       :desc "pandoc md2org" "a p o" #' +jk/convert-markdown-to-format-and-insert
;;       )



;; (map! :leader
;;       :desc "pandoc md2org" "a p" #' +jk/convert-markdown-to-org-in-clipboard-and-insert)

;; 因为=org-capture= 使用的比较多，所以对换 doom emacs 设置的两个按键，使用=x=来打开 org capture
(map! :leader
      :desc "Org Capture" "x" #'org-capture
      :desc "Pop up scratch buffer" "X" #'doom/open-scratch-buffer
      )

;; set undo
(when NOT-ANDROID
  (global-set-key (kbd "C-z") 'undo))


;; 使用类似于 mac 的窗口管理快捷键管理 buffer
(map!
 :g "s-w"       #'kill-this-buffer
 :g "s-["       #'previous-buffer
 :g "s-]"       #'next-buffer
 )

;;  SPC f f 默认搜索当前 buffer 所在的目录，这里更改成搜索当前 buffer 所在的 project
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

;; 打开默认 md 文件
(defun open-default-markdown-file ()
  "Open a specific Markdown file."
  (interactive)
  (find-file (concat +jk/resources-directory "/md2org.md"))
  ;; 直接进入 insert mode
  (evil-insert-state)
  )
(map! :leader
      :desc "Open default markdown file" "o m" #'open-default-markdown-file)


;; 绑定打开 bookmark 的按键，doom emacs 中的默认按键为=C-x r b=
(map! :leader
      :desc "jump to bookmark" "a b" #'bookmark-jump)

(setq doom-leader-key "C-SPC"
      doom-localleader-key "C-SPC m"
      doom-leader-alt-key "C-SPC"
      doom-localleader-alt-key "C-SPC m")

;; open "M-x" by "C-SPC C-SPC"
(map! :leader
      :desc "Open like spacemacs" "C-SPC" #'execute-extended-command)

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (and NOT-ANDROID
             (string-equal (buffer-file-name)
                           (expand-file-name +jk/doom-config-org)))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

;; solve the problem of 'Cmd-x raise M-x rather than cut' problem
;; https://github.com/doomemacs/doomemacs/issues/386

(defun copy-region (beg end)
  "Copies the text to the kill buffer without deleting the selected region."
  (interactive "r")
  (copy-region-as-kill beg end))

;; (defun paste-region ()
;;   "Pastes the text from the kill buffer."
;;   (interactive)
;;   (yank))

(defun paste-region ()
  "Pastes the text from the kill buffer, replacing any selected text."
  (interactive)
  (if (use-region-p)
      (delete-region (region-beginning) (region-end)))
  (yank))

;; 这里 s-v在ubuntu中默认是显示通知列表的快捷键，需要在设置中禁用这个快捷键，才能保证s-v实现粘贴的功能。
(defun cut-region (beg end)
  "Copies the text to the kill buffer and deletes the selected region."
  (interactive "r")
  (copy-region-as-kill beg end)
  (delete-region beg end))

(map!
      "s-c" #'copy-region
      "s-v" #'paste-region
      "s-x" #'cut-region)

;; 通过启用 visual-line-mode 来实现到达屏幕边缘时自动换行。visual-line-mode 是一个 minor mode，它会根据窗口大小而不是固定的列数来换行。
;; (when IS-ANDROID
;;   (add-hook! 'text-mode-hook #'visual-line-mode))

;; 在 text-mode-hook 中添加调试代码，每当进入 Text mode 时，都会在 Emacs 的 *Messages* 缓冲区中打印一条消息，表明该钩子已被执行。
;; (add-hook 'text-mode-hook
;;           (lambda ()
;;             (message "text-mode-hook executed")))

;; https://github.com/doomemacs/doomemacs/issues/3108
(after! gcmh
  (setq gcmh-high-cons-threshold 33554432))

(after! org
  (setq word-wrap-by-category t)
  )

;; 设置中文字体。 测试： 将 直 言 判
;; https://emacs-china.org/t/doom-emacs/23513/8
(defun my-cjk-font()
  (let ((font-name (cond ((eq system-type 'darwin) "STKaiti") ; macOS
                         ((eq system-type 'gnu/linux) "LXGW WenKai") ; Linux
                         (IS-ANDROID "LXGW WenKai")
                         (t "STKaiti")))) ; 默认字体
    (dolist (charset '(kana han cjk-misc symbol bopomofo))
      (set-fontset-font t charset (font-spec :family font-name)))))

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

(when NOT-ANDROID
  (use-package! sis
    :init
    ;; sis-respect-prefix-and-buffer
    ;; sis--prefix-override-map-enable
    (setq sis-prefix-override-keys (list "C-c" "C-x" "C-h" "C-SPC"))

    ;; `C-s/r' 默认优先使用英文 必须在 sis-global-respect-mode 前配置
    (setq sis-respect-go-english-triggers
	  (list 'isearch-forward 'isearch-backward)) ; isearch-forward 命令时默认进入 en
    (setq sis-respect-restore-triggers
	  (list 'isearch-exit 'isearch-abort)) ; isearch-forward 恢复, isearch-exit `<Enter>', isearch-abor `C-g'

    (setq sis--context-triggers-adviced t)
    :config
    (cond
     ;; macOS 系统
     ((string-equal system-type "darwin")
      (sis-ism-lazyman-config
       ;; English input source may be: "ABC", "US" or another one.
       ;; "com.apple.keylayout.ABC"
       "com.apple.keylayout.ABC"
       ;; Other language input source: "rime", "sogou" or another one.
       ;; "im.rime.inputmethod.Squirrel.Rime"
       "com.sogou.inputmethod.sogou.pinyin"))

     ;; Linux 系统
     ((string-equal system-type "gnu/linux")
      (sis-ism-lazyman-config "1" "2" 'fcitx))

     ;; 其他系统，可以根据需要添加更多条件
     ;; ((string-equal system-type "其他系统类型")
     ;;  (配置代码))
     )


    ;; im-select can be used as a drop-in replacement of macism in Microsoft Windows.
    ;; (sis-ism-lazyman-config "1033" "2052" 'im-select) ; 输入码 1033/英文，2052/中文小狼毫

    ;; enable the /cursor color/ mode 中英文光标颜色模式
    (sis-global-cursor-color-mode t)

    ;; enable the /respect/ mode buffer 输入法状态记忆模式
    (sis-global-respect-mode t)

    ;; enable the /inline english/ mode for all buffers
    ;; (sis-global-inline-mode t) ; 中文输入法状态下，中文后<spc>自动切换英文，结束后自动切回中文

    ;; (global-set-key (kbd "<f9>") 'sis-log-mode) ; 开启日志

    ;; 特殊定制
    (setq
     sis-default-cursor-color nil ; 英文光标色
     ;; sis-default-cursor-color "blue" ; 英文光标色
     sis-other-cursor-color "#FF2121" ; 中文光标色
     ;; sis-inline-tighten-head-rule 'all ; 删除头部空格，默认 1，删除一个空格，1/0/'all
     ;; sis-inline-tighten-tail-rule 'all ; 删除尾部空格，默认 1，删除一个空格，1/0/'all
     ;; sis-inline-with-english t ; 默认是 t, 中文 context 下输入<spc>进入内联英文
     ;; sis-inline-with-other t ; 默认是 nil，而且 prog-mode 不建议开启, 英文 context 下输入<spc><spc>进行内联中文
     )

    ;; 当前默认在org mode的列表中按下cmd+enter添加条目时，会将输入法重置为英文。看到sis源码中sis--context-line有做判断，但是并没有起作用，所以先禁用了
    ;; (setq sis-context-triggers nil)


    ;; ;; 特殊 buffer 禁用 sis 前缀,使用 Emacs 原生快捷键  setqsis-prefix-override-buffer-disable-predicates
    ;; (setq sis-prefix-override-buffer-disable-predicates
    ;;       (list 'minibufferp
    ;;             (lambda (buffer) ; magit revision magit 的 keymap 是基于 text property 的，优先级比 sis 更高。进入 magit 后，disable sis 的映射
    ;;     	  (sis--string-match-p "^magit-revision:" (buffer-name buffer)))
    ;;             (lambda (buffer) ; special buffer，所有*打头的 buffer，但是不包括*Scratch* *New, *About GNU 等 buffer
    ;;     	  (and (sis--string-match-p "^\*" (buffer-name buffer))
    ;;     	       (not (sis--string-match-p "^\*About GNU Emacs" (buffer-name buffer))) ; *About GNU Emacs" 仍可使用 C-h/C-x/C-c 前缀
    ;;     	       (not (sis--string-match-p "^\*New" (buffer-name buffer)))
    ;;     	       (not (sis--string-match-p "^\*Scratch" (buffer-name buffer))))))) ; *Scratch*  仍可使用 C-h/C-x/C-c 前缀
    )

  )

;; CSV mode should not wrap
(add-hook! 'csv-mode-hook (toggle-truncate-lines 1))

;; https://github.com/doomemacs/doomemacs/issues/7532
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))

(defun vterm-copy-region (beg end)
  "Copy region in vterm."
  (interactive "r")
  (if (use-region-p)
      (progn
        (copy-region-as-kill beg end)
        (deactivate-mark))
    (message "No region selected")))

(defun vterm-paste-region ()
  "Paste in vterm."
  (interactive)
  (vterm-yank))

(defun vterm-cut-region (beg end)
  "Cut region in vterm."
  (interactive "r")
  (if (use-region-p)
      (progn
        (copy-region-as-kill beg end)
        (delete-region beg end)
        (deactivate-mark))
    (message "No region selected")))

(after! vterm
  (map! :map vterm-mode-map
        "s-c" #'vterm-copy-region
        "s-v" #'vterm-paste-region
        "s-x" #'vterm-cut-region))

(map! :leader
      :desc "vterm" "a t" #'vterm)

;; Kicked out of insert mode when typing 'fd' quickly
;; https://github.com/doomemacs/doomemacs/issues/1946
(after! evil-escape
  (setq-default evil-escape-key-sequence "fd"))

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

  ;; 如果 "Find file in project" （通常绑定到 SPC f f 快捷键）在 Doom Emacs 中列出了已经不存在的文件，这可能是因为项目索引没有更新,你可能需要手动重新生成项目索引。
  ;; (projectile-invalidate-cache nil)
  ;; (setq projectile-enable-caching t)

  )

;; start treemacs on emacs startup
;; (add-hook! 'window-setup-hook #'treemacs 'append)

(when NOT-ANDROID
  (add-hook! 'window-setup-hook #'treemacs))

(after! treemacs
  ;; (defun +jk/treemacs-open-file (file)
  ;;   "Open FILE with an external application."
  ;;   (interactive)
  ;;   (let ((extension (file-name-extension file)))
  ;;     (cond
  ;;      ((string= extension "pdf")
  ;;         (shell-command (format "open -a Skim.app '%s'" file)))
  ;;      (t
  ;;       (treemacs-visit-node-default)))))

  (defun +jk/treemacs-open-file (&rest args)
    "Open FILE with an external application."
    (interactive)
    (let* ((btn (treemacs-current-button))
           (file (when btn (treemacs-safe-button-get btn :path))))
      (when file
        (let ((extension (file-name-extension file)))
          (cond
           ((string= extension "pdf")
            (shell-command (format "open -a Skim.app '%s'" file)))
           (t
            (treemacs-visit-node-default)))))))

  (with-eval-after-load 'treemacs
    ;; (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)
    (treemacs-define-RET-action 'file-node-open #'+jk/treemacs-open-file)
    (treemacs-define-RET-action 'file-node-closed #'+jk/treemacs-open-file)
    (treemacs-define-doubleclick-action 'file-node-open #'+jk/treemacs-open-file)
    (treemacs-define-doubleclick-action 'file-node-closed #'+jk/treemacs-open-file))
  )

(use-package! highlight-parentheses
  :config
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  (add-hook 'minibuffer-setup-hook #'highlight-parentheses-minibuffer-setup)
  )

(featurep 'imagemagick)

   (setq image-use-external-converter t)

(after! org-download
  ;; doom 设置的默认值为"_%Y%m%d_%H%M%S"
  (setq org-download-timestamp "_%Y%m%d_%H%M%S_")
  )

(setq jit-lock-chunk-size 1000)  ; 调整为合适的值
(setq jit-lock-defer-time 0.05)  ; 延迟时间，单位是秒

(setq scroll-preserve-screen-position nil)

(after! org
  ;; 该功能允许在创建到 Org 文件或标题的链接时自动使用 ID。这意味着当你在 Org mode 中创建到另一个 Org 文件或某个特定标题的链接时，会自动生成并使用一个唯一 ID 作为链接的目标，而不是使用文件名和标题。
  (setq org-id-link-to-org-use-id t)

  ;; 添加一个设置来确保每次打开 Org 文件时都启用内嵌图片的显示
  ;; 无需每个文件单独设置 #+STARTUP: inlineimages
  ;; 但是打开这个选项，当 attachment 中有除了图片以为的附件时，显示会出问题
  ;; (setq org-startup-with-inline-images t)
  )

(after! org
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file +jk/org-capture-inbox-file)
           "* TODO %^{Title} \nCreation Time: %U \n%?\n" :prepend t :empty-lines-after 2)
          ("r" "To be read" entry
           (file +jk/org-capture-inbox-file)
           "* TODO Paper title: %^{Title} \nCreation Time: %U \n%?\n" :prepend t :empty-lines-after 2)
          ("i" "Interrupted" entry
           (file +jk/org-capture-inbox-file)
           "* TODO %^{Title} \nCreation Time: %U \n%?\n" :prepend t :clock-in t :clock-resume t :empty-lines-after 2)
          ("m" "Meeting Notes" entry
           (file +jk/org-capture-inbox-file)
           "* 会议记录： %^{Title|未命名会议} \nCreate Time: %U \n参会人: %^{Participant|未填写} \n%?\n" :prepend t :empty-lines-after 2)
          )))
;;          )))

;; (setq org-tab-first-hook '(+org-yas-expand-maybe-h
;;                          org-babel-hide-result-toggle-maybe
;;                          org-babel-header-arg-expand
;;                          +org-clear-babel-results-h
;;                          +org-cycle-only-current-subtree-h)'
;;        )

(after! org
  ;; .stversions 文件夹是 syncthing 使用的版本控制和备份文件，不应该加入到 agenda 中，不然可能造成重复。
  ;; 使用 directory-files-recursively 函数的第三个参数，它是一个正则表达式，用于排除不想包含的文件。但是我们要排除的是一个文件夹里的所有文件，因此需要通过函数改写。
  (defun +jk/org-agenda-files-exclude-stversions (dir regexp)
    "List all files in DIR that match REGEXP, excluding .stversions directory."
    (let ((files (directory-files-recursively dir regexp)))
      (seq-filter (lambda (file)
                    (not (string-match-p "/\\.stversions/" file)))
                  files)))
  ;; "org$"是用来匹配文件名以"org"结尾的正则表达式，即查找所有 Org 文件（.org 扩展名）
  (setq org-agenda-files (+jk/org-agenda-files-exclude-stversions org-directory "\\.org$"))

  ;; (map! "<f1>" #'org-agenda)

  ;; The initial value of follow mode in a ne   wly created agenda window.
  ;; 之前有 bug：evil 开启的情况下，只有使用 jk 作为方向键换行的时候才会跟随，使用方向键不会跟随
  ;; 现在应该是修复了
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
           ((todo "TODO"
                       ((org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled)) ;; 只跳过带有 scheduled 时间戳的条目
                        ;; ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                        ;; (org-agenda-skip-function
                        ;;  `(org-agenda-skip-entry-if
                        ;;    'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                        (org-agenda-block-separator nil)
                        (org-agenda-overriding-header "TODO tasks without a date:\n")))
            (agenda "" ((org-agenda-start-day "+0d")
                        (org-agenda-span 1)
                        (org-deadline-warning-days 0)
                        (org-agenda-block-separator ?*)
                        (org-scheduled-past-days 100000) ;; 显示过去 100000 天（所有）的计划
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

  (defun +jk/my-org-agenda-daily ()
    "Daily agenda and top priority tasks."
    (interactive)
    (org-agenda nil "A"))
  (map! :leader
        :desc "daily agenda" "a a" #'+jk/my-org-agenda-daily)



  ;; 打开 emacs 显示自定义的 agenda view
  ;; (add-hook 'emacs-startup-hook
  ;;           (lambda ()
  ;;             (org-agenda nil "A")
  ;;             (delete-other-windows)))

  ;; 设置 agenda 自动显示时间统计报告
  (setq org-agenda-start-with-clockreport-mode t)

  ;; 设置 org-agenda-clockreport-mode
  (setq org-agenda-clockreport-parameter-plist '(:scope agenda-with-archives :stepskip0 t :link t :maxlevel 3 :fileskip0 t :formula % :hidefiles t))

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
                             ;; (,(directory-files-recursively org-directory "^[a-z0-9]*.org$") :maxlevel . 1)
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
  ;; 设置补全时显示所有 agenda 文件中的 tag
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

(when NOT-ANDROID  ; Check if the system is Mac
  (after! org-roam
    (setq org-roam-directory org-directory)
    (setq org-roam-index-file (concat +jk/org-roam-directory "index.org"))
    ;; 使 org agenda 显示.org_archive 文件中的 todo entry
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

;; manual: https://github.com/org-roam/org-roam-bibtex/blob/main/doc/orb-manual.org
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
            ("b" "bibliography note with bibtex" plain
             "Published by =%^{author}= on *%^{journal}%^{volume}%^{booktitle}%^{publisher}* in ~%^{year}~.\n\n* 摘要\n\n%?\n\n* 原文总结\n\n\n\n* 概念\n\n\n\n* 想法\n\n\n\n"
             :target
             (file+head "paper_notes/${citekey}.org" "#+title: ${title}\n#+note_creation_time: %U\n")
             :unnarrowed t)

            ;; ("b" "bibliography note with bibtex" plain
            ;;  "Published by =%^{author}= on *%^{journal}%^{volume}%^{booktitle}* in ~%^{year}~.\n\n%?"
            ;;  :target
            ;;  (file+head "paper_notes/${citekey}.org" "#+title: ${title}\n#+note_creation_time: %U\n")
            ;;  :unnarrowed t)
            ))
    :hook (org-roam-mode . org-roam-bibtex-mode)
    :custom
    (orb-insert-interface  "ivy-bibtex")
    :config
    (setq orb-roam-ref-format 'org-ref-v3)
    (setq orb-insert-link-description 'citation-org-ref-3)
    (setq orb-preformat-keywords '("citekey" "author" "year" "journal" "volume" "booktitle" "publisher"))
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

(with-eval-after-load 'org
  (remove-hook 'org-tab-first-hook #'+org-indent-maybe-h)
  )

(when NOT-ANDROID
  (after! org
    (setq org-startup-with-latex-preview t) ; 默认启用 LaTeX 预览
    ;; 设置 LaTeX 导出类
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
    (add-to-list 'org-latex-packages-alist '("" "subcaption" t))
    (add-to-list 'org-latex-packages-alist '("" "listings" t))
    (add-to-list 'org-latex-packages-alist '("" "color" t))
    (add-to-list 'org-latex-packages-alist '("" "algorithm" t))
    (add-to-list 'org-latex-packages-alist '("" "algpseudocode" t))
    (add-to-list 'org-latex-packages-alist '("" "graphicx" t))
    (add-to-list 'org-latex-packages-alist '("" "booktabs" t))
    (add-to-list 'org-latex-packages-alist '("" "xcolor" t))
    )

  ;; update the list of LaTeX classes and associated header (encoding, etc.)
  ;; and structure
  (add-to-list 'org-latex-classes
               `("beamer"
                 ,(concat "\\documentclass[presentation]{beamer}\n"
                          "[DEFAULT-PACKAGES]"
                          "[PACKAGES]"
                          "[EXTRA]\n")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

  (setq org-latex-src-block-backend 'listings)
  ;; fragment 太多的话，会非常慢，所以默认关掉
  (setq org-startup-with-latex-preview nil)

  ;; 让 #+BIND 选项生效
  (setq org-export-allow-bind-keywords t)

  ;; 设置默认打开async export 的格式
  ;; 也就是 =C-c C-e= 打开org-export-dispatch 时默认打开async export 选项
  (setq org-export-in-background t)
  ;; 在doomemacs中不能简单使用async_init.el 文件设置org-export-async-init-file，doomemacs已经定义了相关功能
  ;; https://emacs.stackexchange.com/questions/77581/bind-and-org-mode-asynchronous-exporting-document
  ;; 处理beamer目前还要加上 (require 'ox-beamer), 不然会报错
  ;; https://github.com/doomemacs/doomemacs/issues/5768
  (require 'ox-beamer)

  (add-to-list 'org-file-apps '("\\.pdf\\'" . "open -a Skim.app %s"))

  )

(defun +jk/org-get-file-property (property)
  "Get the value of a file-level property in the current Org buffer."
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward (format "^#\\+%s: \\(.*\\)$" property) nil t)
      (match-string 1))))

;; (defun +jk/org-export-to-pdf-based-on-class ()
;;   "Export the current Org buffer to PDF based on the LATEX_CLASS property."
;;   (when (and (eq major-mode 'org-mode)
;;              (string= (+jk/org-get-file-property "AUTO_EXPORT") "t"))
;;     (let ((latex-class (+jk/org-get-file-property "LATEX_CLASS")))
;;       (cond
;;        ((string= latex-class "beamer") (org-beamer-export-to-pdf))
;;        (t (org-latex-export-to-pdf))))))
(defun +jk/org-export-to-pdf-based-on-class ()
  "Export the current Org buffer to PDF based on the LATEX_CLASS property."
  (message "Try to make PDF...")  ; 打印调试信息
  (when (and (eq major-mode 'org-mode)
             (string= (+jk/org-get-file-property "AUTO_EXPORT") "t"))
    (let ((latex-class (+jk/org-get-file-property "LATEX_CLASS")))
      (message "Exporting to PDF...")  ; 打印调试信息
      (message "LATEX_CLASS: %s" latex-class)  ; 打印 LATEX_CLASS 的值
      (cond
       ((string= latex-class "beamer")
        (message "Using Beamer for export.")  ; 打印使用的导出方式
        (org-beamer-export-to-pdf t)) ;; 参数 t 代表异步导出
       (t
        (message "Using default LaTeX for export.")  ; 打印使用的导出方式
        (org-latex-export-to-pdf t))) ;; 参数 t 代表异步导出
      (message "Export finished."))))  ; 打印导出完成的信息


;; (setq org-latex-pdf-process
;;       '("latexmk -pdf -f -interaction=nonstopmode -output-directory=%o %f"))
;; ("latexmk -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f")

(add-hook 'after-save-hook '+jk/org-export-to-pdf-based-on-class)

;; 在 macOS 中，osascript 是用来执行 AppleScript 脚本的命令行工具，这里调用osascript来输出通知
;; 如果要改变通知的显示方式，要在设置中设置script editor的通知方式
;; Script Editor 是 macOS 上的一个应用程序，用于编写和运行 AppleScript 和 JavaScript 脚本。
(defun send-notification (title message)
  "Send a macOS notification if on a macOS system."
  (when (eq system-type 'darwin)
    (let ((script (format "display notification \"%s\" with title \"%s\""
                          message title)))
      (start-process "osascript-send-notification" nil "osascript" "-e" script))))

;; 也可以尝试使用第三方工具terminal-notifier
;; (defun send-notification (title message)
;;   "Send a macOS notification using terminal-notifier."
;;   (when (eq system-type 'darwin)
;;     (start-process "terminal-notifier"
;;                    nil
;;                    "terminal-notifier"
;;                    "-title" title
;;                    "-message" message
;;                    "-activate" "com.apple.Terminal"
;;                    "-timeout" "0")))

;; test
;; (send-notification "Pomodoro Complete" "Take a break!")


(defun current-time-string ()
  "Return the current time as a string in 'HH:MM' format."
  (format-time-string "%H:%M"))

(use-package! org-pomodoro
  :after org
  :config
  (setq
   org-pomodoro-length 25
   org-pomodoro-short-break-length 5
   ;; 完成一个时间段后，是否需要人为停止。如果设置了 org-pomodoro-manual-break 为 true，需要手动运行 org-pomodoro 结束当前周期，进入休息阶段
   org-pomodoro-manual-break t
   org-pomodoro-keep-killed-pomodoro-time t

   ;; 下载华为提示音: https://sc.chinaz.com/yinxiao/161008432362.htm
   ;; 配置提示音频为 pomodoro 的提示音
   org-pomodoro-start-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-finished-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-overtime-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-short-break-sound (concat +jk/resources-directory "/huawei.wav")
   org-pomodoro-long-break-sound (concat +jk/resources-directory "/huawei.wav")
   )

  (add-hook 'org-pomodoro-overtime-hook
            (lambda ()
              (send-notification "Pomodoro Overtime" (format "It's %s. You should be resting now! Consider taking a break." (current-time-string)))))

  ;; (add-hook 'org-pomodoro-finished-hook
  ;;           (lambda ()
  ;;             (send-notification "Pomodoro Finished" (format "It's %s. Time for a break!" (current-time-string)))))

  (add-hook 'org-pomodoro-short-break-finished-hook
            (lambda ()
              (send-notification "Short Break Finished" (format "It's %s. Back to work!" (current-time-string)))))

  (add-hook 'org-pomodoro-long-break-finished-hook
            (lambda ()
              (send-notification "Long Break Finished" (format "It's %s. Ready for another pomodoro?" (current-time-string)))))

  )

;; be careful
;; maybe not work and have side effects
;; https://github.com/emacs-evil/evil/issues/1623
(advice-remove 'set-window-buffer #'ad-Advice-set-window-buffer)

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
        org-modern-block-fringe t
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

;; (setq +jk/org-excalidraw-directory (concat +jk/resources-directory "excalidraw-files/"))

;; (use-package org-excalidraw
;;   :after org
;;   :config
;;   (org-excalidraw-directory +jk/org-excalidra-directory)
;; )

(defun dc/alert-android-notifications-notify (info)
  "Send notifications using android-notifications-notify.
android-notifications-notify is a built-in function in the native Emacs
Android port."
  (let ((title (or (plist-get info :title) "Android Notifications Alert"))
        (body (or (plist-get info :message) ""))
        (urgency (cdr (assq (plist-get info :severity)
                            alert-notifications-priorities)))
        (icon (or (plist-get info :icon) alert-default-icon))
        (replaces-id (gethash (plist-get info :id) alert-notifications-ids)))
    (message "dc/alert-android-notifications-notify called with arg: %s" info)
    (message "dc/alert-android-notifications-notify called with title: %s body: %s urgency: %s icon: %s replaces-id: %s" title body urgency icon replaces-id)
    (android-notifications-notify
     :title title
     :body body
     :urgency urgency
     :icon icon
     :replaces-id replaces-id)
    (message "finished my function...")
    ))

;; https://github.com/jwiegley/alert
(use-package! alert
  :config
  ;;  (setq alert-default-style 'osx-notifier)
  (alert-define-style 'android-notifications :title "Android Notifications"
                      :notifier #'dc/alert-android-notifications-notify)
  )

;; org-alert 包本身有 bug
(use-package! org-alert
  :after (org alert)
  :custom
  ;; Use different backends depending on the platform
  (alert-default-style (cond ((eq system-type 'darwin) 'osx-notifier)
                             ((eq system-type 'gnu/linux) 'libnotify)
                             ((eq system-type 'android) 'android-notifications)
                             (t 'message)))

  :config
  ;; Setup timing
  (setq org-alert-interval 300  ;; a timer which periodically calls org-alert-check (defaults to 300s).
        org-alert-notify-cutoff 5 ;; controls how long before a scheduled event a notification should be sent (defaults to 10minutes).
        org-alert-notify-after-event-cutoff 2 ;; controls how long after a scheduled event to continue sending notifications (defaults to 10minutes).
        )

  ;; Setup notification title (if using 'custom)
  (setq org-alert-notification-title "Org")

  ;; BUG 当同时设置 deadline 和 schedule 时，只提醒匹配到的第一个时间，比如：
  ;; * TODO Paper title: Transformer In;; terpretability Beyond Attention Visualization
  ;; DEADLINE: <2024-03-01 Fri 11:20> SCHEDULED: <2024-03-01 Fri 11:10>
  ;;  Creation Time: [2024-02-28 Wed]
  ;; 上述的只会在deadline时间提醒
  ;; IDEA 对仅设置了日期但没有设置时间的item，会产生什么样的行为？

  ;; Use non-greedy regular expression
  (setq org-alert-time-match-string
        "\\(?:SCHEDULED\\|DEADLINE\\):.*?<.*?\\([0-9]\\{2\\}:[0-9]\\{2\\}\\).*>")

  ;; Enable org-alert
  ;; BUG 在配置中打开 org-alert 会导致 org mode 文件渲染的问题，应该是和 org-modern 等用来美化 org mode 的包不兼容
  ;; 如果需要的话，尝试手动打开
  ;; 这里设置只在android才默认打开
  (when IS-ANDROID
    (org-alert-enable))
  )

;; ============================================================================
;; 性能优化和监控 (Added for Emacs 29.4 freeze issues)
;; ============================================================================

;; 加载性能修复
(load! "performance-fixes")

;; 加载调试工具
(load! "debug-performance")

;; 启用命令计时器,监控慢命令 (可选,会在 *Messages* 中显示慢命令)
;; 取消注释下面这行来启用:
;; (my/enable-command-timer)
