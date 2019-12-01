# org-mode的文件链接打开 other-window

设置变量 org-link-frame-setup

``` emacs-lisp
 '(org-link-frame-setup
   (quote
	((vm . vm-visit-folder-other-frame)
	 (vm-imap . vm-visit-imap-folder-other-frame)
	 (gnus . org-gnus-no-new-news)
	 (file . find-file-other-window)
	 (wl . wl-other-frame))))
```
