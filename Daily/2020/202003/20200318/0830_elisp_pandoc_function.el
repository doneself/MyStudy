(defun pandoc-file (file-path from-type to-type)
  (interactive
   (list
	(read-file-name "选择文件：")
	(completing-read
		  "Select from type:"
		  '("docx" "html" "markdown" "org"))
	(completing-read
		  "Select to type:"
		  '("plain" "docx" "markdown_strict" "html" "slidy"))
	))
  (let* ((file-name-noext (file-name-sans-extension (file-name-nondirectory file-path)))
		 (file-extension (cond ((string= to-type "plain") ".txt")
							   ((string= to-type "docx") ".docx")
							   ((string= to-type "markdown_strict") ".md")
							   ((string= to-type "html") ".html")
							   ((string= to-type "slidy") ".html")
							   (t "")))
		 (output-filename (concat file-name-noext file-extension))
		 (pandoc-command (format "pandoc -f %s -t %s %s -o %s" from-type to-type file-path output-filename)))
	(shell-command pandoc-command)
	(message "Pandoc convert finished.")))
