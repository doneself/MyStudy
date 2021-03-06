(defun fileds-to-nhibernate-hbm ()
  (interactive)
  (let ((result-buffer-name "*Nhibernate hbm*")
		(field-list (split-string (buffer-string) "[ \f\t\n\r\v]+" t))
		(num-i 1))
	(with-current-buffer
		(set-buffer (get-buffer-create result-buffer-name))
	  (erase-buffer)
	  (insert "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n")
	  (insert "<hibernate-mapping xmlns=\"urn:nhibernate-mapping-2.2\" namespace=\"Project.Models\" assembly=\"Project.Models\">\n")
	  (insert "  <class name=\"Object\" table=\"Table\" schema=\"Schema\" lazy=\"true\">\n")
	  (mapcar (lambda(item)
				(when (= num-i 1)
				  (insert (format "    <id name=\"%s\" column=\"%s\">\n" item item))
				  (insert "      <generator class=\"assigned\" />\n")
				  (insert "    </id>\n"))
				(unless (= num-i 1)
				  (insert (format "    <property name=\"%s\" column=\"%s\" />\n" item item))
				  )
				(setq num-i (+ num-i 1))) field-list)
	  (insert "  </class>\n")
	  (insert "</hibernate-mapping>")
	  (goto-char (point-min))
	  (display-line-numbers-mode t))
	(switch-to-buffer-other-window result-buffer-name)))
