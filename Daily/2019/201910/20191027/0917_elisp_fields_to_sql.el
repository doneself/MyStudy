;;elisp fields to sql

(defun fields-to-insert-sql (select-symbol)
  (interactive (list (completing-read "Select symbol:" (list ":" "@"))))
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
	(mapcar (lambda(item) (insert (format "%s%s, " select-symbol (string-trim item)))) field-list)
	(backward-delete-char-untabify 2)
	(insert ")"))
	(switch-to-buffer-other-window result-buffer-name)))


(defun fields-to-update-sql (select-symbol)
  (interactive (list (completing-read "Select symbol:" (list ":" "@"))))
  (require 'subr-x)
  (let ((result-buffer-name "*Sql String*")
		(field-list (split-string (buffer-string) "[ \f\t\n\r\v]+" t)))
	(with-current-buffer
		(set-buffer (get-buffer-create result-buffer-name))
	  (erase-buffer)
	  (insert "UPDATE tablename SET ")
	  (mapcar (lambda(item) (insert (format "%s = %s%s, " (string-trim item) select-symbol (string-trim item)))) field-list)
	  (backward-delete-char-untabify 2)
	  (switch-to-buffer-other-window result-buffer-name))))

(defun fields-to-select-sql()
  (interactive)
  (require 'subr-x)
  (let ((as-name (read-string "Enter table rename : "))
		(result-buffer-name "*Sql String*")
		(field-list (split-string (buffer-string) "[ \f\t\n\r\v]+" t)))
	(with-temp-buffer
	  (set-buffer (get-buffer-create result-buffer-name))
	  (erase-buffer)
	  (insert "SELECT \n")
	  (mapcar (lambda(item)
				(insert (if (string-blank-p as-name)
							(format "%s, " item)
						  (format "%s.%s, " as-name item)))) field-list)
	  (backward-delete-char-untabify 2)
	  (insert "\nFROM tablename")
	  (unless (string-blank-p as-name)
		(insert (format " AS %s" as-name))))
	(switch-to-buffer-other-window result-buffer-name)))