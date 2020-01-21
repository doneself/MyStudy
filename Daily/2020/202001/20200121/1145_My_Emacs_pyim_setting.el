;;;;;;;;;;;;;pyim;;;;;;;;;;;;;;
(require 'org)
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
;;(add-hook 'org-mode-hook (lambda() (define-key org-mode-map (kbd "C-.") 'toggle-input-method)))
(setq pyim-page-tooltip 'posframe)
(setq pyim-posframe-min-width 0)
(setq pyim-title "拼音")
(setq pyim-page-style 'vertical)
(setq pyim-punctuation-translate-p '(auto yes no))   ;中文使用全角标点，英文使用半角标点。
;;(setq-default pyim-punctuation-translate-p '(no yes auto))   ;使用半角标点。

;;#b4eeb4
(setq posframe-arghandler #'my-posframe-arghandler)
(defun my-posframe-arghandler (buffer-or-name arg-name value)
  (let ((info '(:internal-border-width 10 :foreground-color "#000000" :background-color "#b4eeb4" :font "微软雅黑 16")))
    (or (plist-get info arg-name) value)))

(defun auto-switch-to-english()
  (interactive)
  (if (string= current-input-method 'pyim)
	  (toggle-input-method)))
(add-hook 'helm--minor-mode-hook 'auto-switch-to-english)

;;(setq-default pyim-english-input-switch-functions '(helm--minor-mode))

