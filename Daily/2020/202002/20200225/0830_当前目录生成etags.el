;;当前目录生成etags

(defun build-etags-default-directory (regexp-input)
  (interactive
   (list
		 (read-string "输入搜索正则，默认(cs|js|el) : ")))
  (require 'subr-x)
  (let* (
		 (regexp-string (if (string-blank-p regexp-input)
							(rx "." (or "cs" "js" "el"))
						  regexp-input))
		 (file-list (directory-files-recursively default-directory regexp-string)))
	(shell-command (concat "etags " (string-join file-list " ")))
	))
