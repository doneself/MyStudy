# org打开连接在other-window

``` emacs-lisp
 '(org-link-frame-setup
   (quote
	((vm . vm-visit-folder-other-frame)
	 (vm-imap . vm-visit-imap-folder-other-frame)
	 (gnus . org-gnus-no-new-news)
	 (file . find-file-other-window)
	 (wl . wl-other-frame))))
```

