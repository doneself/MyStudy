;;elisp fields to sql

(defun fields-to-insert-sql ()
  (interactive)
  (require 'subr-x)
  (let ((result-buffer-name "*Sql String*")
		(field-list (split-string (buffer-string) "[ \f\t\n\r\v]+" t)))
	(with-current-buffer
		(set-buffer (get-buffer-create result-buffer-name))
	  (erase-buffer)
	  (insert "insert into tablename \n(")
	(mapcar (lambda(item) (insert (format "%s, " (string-trim item)))) field-list)
	(backward-delete-char-untabify 2)
	(insert ")\n values \n(")
	(mapcar (lambda(item) (insert (format ":%s, " (string-trim item)))) field-list)
	(backward-delete-char-untabify 2)
	(insert ")"))
	(switch-to-buffer-other-window result-buffer-name)))


(defun fields-to-update-sql ()
  (interactive)
  (require 'subr-x)
  (let ((result-buffer-name "*Sql String*")
		(field-list (split-string (buffer-string) "[ \f\t\n\r\v]+" t)))
	(with-current-buffer
		(set-buffer (get-buffer-create result-buffer-name))
	  (erase-buffer)
	  (insert "UPDATE tablename SET ")
	  (mapcar (lambda(item) (insert (format "%s = :%s, " (string-trim item) (string-trim item)))) field-list)
	  (backward-delete-char-untabify 2)
	  (switch-to-buffer-other-window result-buffer-name))))
