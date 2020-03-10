;;emacs open kdiff

(defun kdiff-files (path1 path2)
  (interactive
   (list (read-file-name "选择文件(1)：")
		 (read-file-name "选择文件(2):")))
  (let ((kdiff-path "C:/Program Files/KDiff3/kdiff3.exe"))
	(if (and
		 (and (file-exists-p path1) (not (file-directory-p path1)))
		 (and (file-exists-p path1) (not (file-directory-p path2))))
		(w32-shell-execute "open" kdiff-path (format " -b %s %s" path1 path2))
	  (message "Please select exist file."))))


(defun kdiff-buffers ()
  (interactive)
  (let* ((kdiff-path "C:/Program Files/KDiff3/kdiff3.exe")
		 (file-buffer-list (remove-if-not (lambda(item) (buffer-file-name item)) (buffer-list)))
		 (file-buffer-name-list (cl-loop for bur in file-buffer-list collect (buffer-name bur)))
		 (buffer1 (completing-read "选择buffer(1):" file-buffer-name-list nil t))
		 (buffer2 (completing-read "选择buffer(2):" file-buffer-name-list nil t)))
	(w32-shell-execute "open" kdiff-path (format " -b %s %s" (buffer-file-name (get-buffer buffer1)) (buffer-file-name (get-buffer buffer2))))
	))


(defun kdiff-buffers-full-filename ()
  (interactive)
  (let* ((kdiff-path "C:/Program Files/KDiff3/kdiff3.exe")
		 (file-buffer-list (remove-if-not (lambda(item) (buffer-file-name item)) (buffer-list)))
		 (file-buffer-name-list (cl-loop for bur in file-buffer-list collect (buffer-file-name bur)))
		 (buffer1 (completing-read "选择buffer(1):" file-buffer-name-list nil t))
		 (buffer2 (completing-read "选择buffer(2):" file-buffer-name-list nil t)))
	(w32-shell-execute "open" kdiff-path (format " -b %s %s" buffer1 buffer2))
	))
