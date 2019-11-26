;; helm-type-file-actions


(setq helm-type-file-actions
	  (quote
	(("Find file" . helm-find-many-files)
	 ("Find file as root" . helm-find-file-as-root)
	 ("View file" . view-file)
	 ("Find file other window" . find-file-other-window)
	 ("Open dired in file's directory" . helm-open-dired)
	 ("Attach file(s) to mail buffer `C-c C-a'" . helm-ff-mail-attach-files)
	 ("Marked files in dired" . helm-marked-files-in-dired)
	 ("Grep File(s) `C-u recurse'" . helm-find-files-grep)
	 ("Zgrep File(s) `C-u Recurse'" . helm-ff-zgrep)
	 ("Pdfgrep File(s)" . helm-ff-pdfgrep)
	 ("Insert as org link" . helm-files-insert-as-org-link)
	 ("Checksum File" . helm-ff-checksum)
	 ("Ediff File" . helm-find-files-ediff-files)
	 ("Ediff Merge File" . helm-find-files-ediff-merge-files)
	 ("Etags `M-., C-u reload tag file'" . helm-ff-etags-select)
	 ("View file" . view-file)
	 ("Insert file" . insert-file)
	 ("Add marked files to file-cache" . helm-ff-cache-add-file)
	 ("Delete file(s)" . helm-ff-delete-files)
	 ("Copy file(s) `M-C, C-u to follow'" . helm-find-files-copy)
	 ("Rename file(s) `M-R, C-u to follow'" . helm-find-files-rename)
	 ("Symlink files(s) `M-S, C-u to follow'" . helm-find-files-symlink)
	 ("Relsymlink file(s) `C-u to follow'" . helm-find-files-relsymlink)
	 ("Hardlink file(s) `M-H, C-u to follow'" . helm-find-files-hardlink)
	 ("Open file externally (C-u to choose)" . helm-open-file-externally)
	 ("Open file with default tool" . helm-open-file-with-default-tool)
	 ("Find file in hex dump" . hexl-find-file))))

