;;; performance-fixes.el --- Performance optimization for Emacs 29.4 -*- lexical-binding: t; -*-

;; 这个文件包含了针对 Emacs 29.4 卡死问题的修复
;; 使用方法: 在 config.el 末尾添加 (load! "performance-fixes")

;;; ============================================================================
;;; 1. org-element-cache 问题修复 (Emacs 29 最常见的卡死原因)
;;; ============================================================================

;; org-element-cache 在 Emacs 29 中有已知的性能问题
;; 参考: https://github.com/doomemacs/doomemacs/issues/7532
(after! org
  ;; 方案 A: 完全禁用 cache (最安全,但会稍微降低性能)
  (setq org-element-use-cache nil)

  ;; 方案 B: 如果方案 A 不够,可以尝试禁用 element cache 的持久化
  ;; (setq org-element-cache-persistent nil)

  ;; 禁用 org-element 的警告(因为我们已经知道问题了)
  (setq org-element--cache-self-verify nil
        org-element--cache-self-verify-frequency 0.0)
  )

;;; ============================================================================
;;; 2. 优化 org-agenda 性能
;;; ============================================================================

(after! org-agenda
  ;; 限制 agenda 扫描的文件数量
  ;; 如果你的 org-agenda-files 太多,考虑只包含真正需要的文件
  ;; (setq org-agenda-files (list (concat org-directory "/agenda/")))

  ;; 禁用 follow mode (这会显著提升 agenda 性能)
  (setq org-agenda-start-with-follow-mode nil)

  ;; 减少 agenda 的刷新频率
  (setq org-agenda-inhibit-startup t)  ; 不在 agenda 中运行 org-startup

  ;; 延迟 clockreport 的生成
  (setq org-agenda-start-with-clockreport-mode nil)

  ;; 优化 scheduled 项目的显示
  (setq org-agenda-dim-blocked-tasks nil)  ; 不要给阻塞的任务变暗
  )

;;; ============================================================================
;;; 3. 优化 org-roam 性能
;;; ============================================================================

(when (featurep 'org-roam)
  (after! org-roam
    ;; 禁用自动同步(改为手动)
    (org-roam-db-autosync-mode -1)

    ;; 如果需要同步,可以手动运行: M-x org-roam-db-sync
    ))

;;; ============================================================================
;;; 4. 优化 LSP 性能
;;; ============================================================================

(after! lsp-mode
  ;; 减少 LSP 的文件监控
  (setq lsp-enable-file-watchers nil)

  ;; 减少 LSP 日志
  (setq lsp-log-io nil)

  ;; 增加读取输出的限制
  (setq read-process-output-max (* 1024 1024)) ; 1MB

  ;; 减少 LSP 的空闲延迟
  (setq lsp-idle-delay 0.5)
  )

;;; ============================================================================
;;; 5. 优化垃圾回收
;;; ============================================================================

;; 你当前的配置已经设置了较高的 GC 阈值,这是好的
;; 但我们可以在 minibuffer 激活时暂时禁用 GC

(defun my/minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my/minibuffer-exit-hook ()
  (setq gc-cons-threshold 33554432))  ; 32MB

(add-hook 'minibuffer-setup-hook #'my/minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my/minibuffer-exit-hook)

;;; ============================================================================
;;; 6. 优化文件 IO
;;; ============================================================================

;; 增加读取进程输出的限制 (对 LSP, vterm 等有帮助)
(setq read-process-output-max (* 1024 1024)) ; 1MB

;; 优化大文件处理
(when (fboundp 'so-long-enable)
  (so-long-enable))

;;; ============================================================================
;;; 7. 禁用一些自动功能
;;; ============================================================================

;; 如果仍然卡死,可以尝试禁用这些功能:

;; 禁用自动换行检测(对大文件有帮助)
;; (setq-default bidi-display-reordering nil)

;; 禁用字体锁定在长行
;; (setq-default font-lock-maximum-decoration 2)

;; 限制单行的长度
(setq-default long-line-threshold 1000)
(setq-default large-hscroll-threshold 1000)

;;; ============================================================================
;;; 8. 优化 sis (输入法切换)
;;; ============================================================================

;; sis 可能会导致卡顿,特别是在 org-mode 中
;; 如果问题严重,可以临时禁用:
;; (when (featurep 'sis)
;;   (sis-global-respect-mode -1)
;;   (sis-global-cursor-color-mode -1))

;;; ============================================================================
;;; 9. 监控和日志
;;; ============================================================================

;; 启用详细的警告信息(帮助定位问题)
(setq warning-minimum-level :error)  ; 只显示错误级别的警告

;; 记录长时间的 GC
(setq garbage-collection-messages nil)  ; 不显示 GC 消息

(message "✓ Performance fixes loaded. 如果仍然卡死:")
(message "  1. M-x my/enable-profiler (需要先加载 debug-performance.el)")
(message "  2. 重现卡死,然后 M-x my/show-profiler-report")
(message "  3. 检查报告中哪些函数占用时间最多")

(provide 'performance-fixes)
