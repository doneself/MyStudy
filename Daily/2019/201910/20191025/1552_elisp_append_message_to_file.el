;;elisp append message to file

(defun append-to-home-set-file()
  (interactive)
  (let ((append-content
		 (if (region-active-p)
			 (buffer-substring-no-properties (region-beginning) (region-end))
		   (buffer-substring-no-properties (line-beginning-position) (line-end-position)))))
	(if (file-exists-p homepage-file-path)
		(append-to-file (format "\n%s" append-content) nil homepage-file-path)
	  (message (format "[%s] not exist." homepage-file-path)))
	(message "Content append finished.")))


(buffer-substring-no-properties (region-beginning) (region-end))
