;;; debug-performance.el --- Performance debugging utilities -*- lexical-binding: t; -*-

;; 这个文件提供了一些工具来帮助排查 Emacs 卡死问题
;; 使用方法: M-x load-file ~/.config/doom/debug-performance.el

;;; 1. 启用性能分析
(defun my/enable-profiler ()
  "启动 CPU profiler,用于分析哪些函数占用了最多时间"
  (interactive)
  (profiler-start 'cpu)
  (message "Profiler started. 当卡死发生后,运行 M-x my/show-profiler-report"))

(defun my/show-profiler-report ()
  "显示 profiler 报告"
  (interactive)
  (profiler-stop)
  (profiler-report)
  (message "Profiler report generated. 按 'q' 退出报告"))

;;; 2. 检查当前 GC 状态
(defun my/show-gc-stats ()
  "显示垃圾回收统计信息"
  (interactive)
  (message "GC 次数: %d, GC 耗时: %.2f 秒, GC 阈值: %s"
           gcs-done
           gc-elapsed
           (if (boundp 'gc-cons-threshold)
               (format "%dMB" (/ gc-cons-threshold 1024 1024))
             "未知")))

;;; 3. 监控命令执行时间
(defvar my/command-timer nil)

(defun my/command-start ()
  (setq my/command-timer (current-time)))

(defun my/command-end ()
  (when my/command-timer
    (let ((elapsed (float-time (time-subtract (current-time) my/command-timer))))
      (when (> elapsed 0.5)  ; 只显示超过 0.5 秒的命令
        (message "⏱ 命令 %s 耗时: %.2f 秒" this-command elapsed)))
    (setq my/command-timer nil)))

(defun my/enable-command-timer ()
  "启用命令计时器,监控慢命令"
  (interactive)
  (add-hook 'pre-command-hook #'my/command-start)
  (add-hook 'post-command-hook #'my/command-end)
  (message "命令计时器已启用,慢命令(>0.5s)将被记录"))

(defun my/disable-command-timer ()
  "禁用命令计时器"
  (interactive)
  (remove-hook 'pre-command-hook #'my/command-start)
  (remove-hook 'post-command-hook #'my/command-end)
  (message "命令计时器已禁用"))

;;; 4. 检查 org-element-cache 问题
(defun my/disable-org-element-cache ()
  "禁用 org-element-cache (这是 Emacs 29 常见的卡死原因)"
  (interactive)
  (setq org-element-use-cache nil)
  (message "org-element-cache 已禁用,需要重启 Emacs"))

;;; 5. 检查当前 buffer 的大小和状态
(defun my/show-buffer-info ()
  "显示当前 buffer 的性能相关信息"
  (interactive)
  (message "Buffer: %s, Size: %d, Major mode: %s, Minor modes: %d active"
           (buffer-name)
           (buffer-size)
           major-mode
           (length (seq-filter (lambda (mode)
                                 (and (boundp mode) (symbol-value mode)))
                               minor-mode-list))))

;;; 6. 快速禁用可能导致卡顿的功能
(defun my/emergency-mode ()
  "紧急模式:禁用所有可能导致卡顿的功能"
  (interactive)
  (when (yes-or-no-p "这将禁用 LSP, org-roam, treemacs 等功能。继续?")
    ;; 禁用 LSP
    (when (fboundp 'lsp-mode)
      (lsp-disconnect)
      (message "LSP 已断开"))

    ;; 禁用 org-element-cache
    (setq org-element-use-cache nil)

    ;; 禁用 treemacs
    (when (and (fboundp 'treemacs-current-visibility)
               (eq (treemacs-current-visibility) 'visible))
      (delete-window (treemacs-get-local-window)))

    ;; 禁用自动保存
    (setq auto-save-default nil)

    (message "紧急模式已激活。建议重启 Emacs。")))

;;; 7. 检查 org-agenda 性能
(defun my/benchmark-org-agenda ()
  "测试 org-agenda 的性能"
  (interactive)
  (let ((start-time (current-time)))
    (org-agenda-list)
    (let ((elapsed (float-time (time-subtract (current-time) start-time))))
      (message "org-agenda 生成耗时: %.2f 秒" elapsed)
      (when (> elapsed 3.0)
        (message "⚠️  org-agenda 很慢! 考虑减少 org-agenda-files 的数量")))))

(message "性能调试工具已加载。可用命令:")
(message "  M-x my/enable-profiler - 启动性能分析")
(message "  M-x my/enable-command-timer - 监控慢命令")
(message "  M-x my/show-gc-stats - 显示 GC 统计")
(message "  M-x my/disable-org-element-cache - 禁用 org-element-cache")
(message "  M-x my/emergency-mode - 紧急模式")
(message "  M-x my/benchmark-org-agenda - 测试 agenda 性能")

(provide 'debug-performance)
