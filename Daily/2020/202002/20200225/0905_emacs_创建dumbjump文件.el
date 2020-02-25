;;emacs lisp 创建dumbjump文件

(defun create-dot-dumbjump (dir)
  (interactive
   (list (read-directory-name "选择路径：")))
  (let* ((file-name ".dumbjump")
		 (file-name-as-directory dir)
		 (full-name (concat dir file-name)))
	(with-temp-file full-name)
	(message (format "%s created." full-name))))
