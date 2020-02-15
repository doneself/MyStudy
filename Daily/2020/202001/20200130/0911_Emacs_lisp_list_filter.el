;;Emacs lisp list filter

(with-current-buffer "*scratch*"
  (insert "aaaaaa"))


(with-current-buffer (get-buffer-create "my buffer list")
(erase-buffer)
(insert "aaaaaa")
(switch-to-buffer-other-window "my buffer list"))

(let* ((my-buffer-name "my buffer list")
	   (my-buffer-list (buffer-list)))
  (with-current-buffer (get-buffer-create my-buffer-name)
	(erase-buffer)
	(mapcar
	 (lambda(item)
	   (insert "\n")
	   (insert (buffer-name item))) my-buffer-list)
	(switch-to-buffer-other-window my-buffer-name))
)


(let* ((my-buffer-name "my buffer list")
	   (my-buffer-list (buffer-list))
	   (my-filter-buffer-list
		(cl-delete-if
		  (lambda (item)
			(or
			 (string-prefix-p " *Minibuf-" (buffer-name item))
			 (string-prefix-p " *which-key" (buffer-name item))
			 (string-prefix-p " *Echo" (buffer-name item))
			 (string-prefix-p " *helm" (buffer-name item))
			 (string-prefix-p "*helm" (buffer-name item))
			 (string-prefix-p " *code-conversion" (buffer-name item))
			 (string-prefix-p " *urlparse" (buffer-name item))
			 )) my-buffer-list)))
  (with-current-buffer (get-buffer-create my-buffer-name)
	;; (erase-buffer)
	(goto-char (point-max))
	(insert "\n\n")
	(mapcar
	 (lambda(item)
	   (insert "\n")
	   (insert (buffer-name item))) my-buffer-list)
	(switch-to-buffer-other-window my-buffer-name))
)
