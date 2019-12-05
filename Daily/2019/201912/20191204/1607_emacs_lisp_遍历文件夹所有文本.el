emacs lisp 遍历文件夹所有文本

(mapcar (lambda(item) (insert (format "\n%s" item))) (directory-files-recursively "d:/Zero/MyDocument/Note/" "[(\\.txt$)(\\.org$)]"))

(rx "." (or "org" "md" "txt"))

(mapcar (lambda(item) (insert (format "\n%s" item)))(directory-files-recursively "D:/ZerOne/MyMemo" "\\.\\(?:org\\|txt\\)$"))


;;read-directory-name
(read-directory-name "选择路径：")


(defun get-directory-note-file (dir)
  (interactive
   (list (read-directory-name "选择路径：")))
  (let* ((note-list-buffer-name "*Note List*"))
	(with-current-buffer
		(set-buffer (get-buffer-create note-list-buffer-name))
	  (erase-buffer)
	  (insert (format "Search time: %s\n" (format-time-string "%Y-%m-%d %a %H:%M:%S")))
	  (mapcar (lambda(item) (insert (format "\n%s" item)))
			  (directory-files-recursively dir (rx "." (or "org" "txt" "md"))))
	  (goto-char (point-min))
	  (display-line-numbers-mode t))
	(switch-to-buffer-other-window note-list-buffer-name)))

(defun get-directory-note-file (dir regexp-input)
  (interactive
   (list (read-directory-name "选择路径：")
		 (read-string "输入搜索正则，默认(txt|org|md) : ")))
  (require 'subr-x)
  (let* ((note-list-buffer-name "*Note List*")
		 (regexp-string (if (string-blank-p regexp-input)
							(rx "." (or "org" "txt" "md"))
						  regexp-input)))
	(with-current-buffer
		(set-buffer (get-buffer-create note-list-buffer-name))
	  (erase-buffer)
	  (insert (format "Search time: %s\n" (format-time-string "%Y-%m-%d %a %H:%M:%S")))
	  (mapcar (lambda(item) (insert (format "\n%s" item)))
			  (directory-files-recursively dir regexp-string))
	  (goto-char (point-min))
	  (display-line-numbers-mode t))
	(switch-to-buffer-other-window note-list-buffer-name)))
