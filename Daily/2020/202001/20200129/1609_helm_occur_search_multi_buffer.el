;;helm occur search multi buffer

;;2020-01-31 Fri 10:02:27
(defun helm-multi-occur-buffer-filter (buffer)
  (or
   (string-prefix-p " *Minibuf-" (buffer-name buffer))
   (string-prefix-p " *which-key" (buffer-name buffer))
   (string-prefix-p " *Echo" (buffer-name buffer))
   (string-prefix-p " *helm" (buffer-name buffer))
   (string-prefix-p "*helm" (buffer-name buffer))
   (string-prefix-p " *code-conversion" (buffer-name buffer))
   (string-prefix-p " *urlparse" (buffer-name item))
   ))

(defun helm-search-text-in-all-buffers()
  (interactive)
  (require 'cl)
  (require 'helm-occur)
  (unless (region-active-p)
	(helm-multi-occur-1
	 (cl-delete-if
	  (lambda(item) (helm-multi-occur-buffer-filter item)) (buffer-list))
	 ))
  (when (region-active-p)
	(helm-multi-occur-1
	 ;;(cl-delete-if (lambda (buffer) (find (aref (buffer-name buffer) 0) " *")) (buffer-list))
	 (cl-delete-if
	  (lambda (item) (helm-multi-occur-buffer-filter item)) (buffer-list))
	 (buffer-substring-no-properties (region-beginning) (region-end)))))


;;;2020-01-30 Thu 09:56:51
(defun helm-search-text-in-all-buffers()
  (interactive)
  (require 'cl)
  (require 'helm-occur)
  (unless (region-active-p)
	(helm-multi-occur-1
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
		 )) (buffer-list))
	 ))
  (when (region-active-p)
	(helm-multi-occur-1
	 ;;(cl-delete-if (lambda (buffer) (find (aref (buffer-name buffer) 0) " *")) (buffer-list))
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
		 )) (buffer-list))
	 (buffer-substring-no-properties (region-beginning) (region-end)))))


;;2020-01-29 Wed 09:57:15
(defun helm-search-text-in-all-buffers()
  (interactive)
  (require 'cl)
  (require 'helm-occur)
  (unless (region-active-p)
	(helm-multi-occur-1
	 (seq-filter (lambda (buf)
			   (not (or
					 (string-prefix-p "*Messages" (buffer-name buf))
					 (string-prefix-p " *Echo" (buffer-name buf))
					 (string-prefix-p " *Minibuf-" (buffer-name buf))
					 (string-prefix-p "*Ibuffer" (buffer-name buf))
					 (string-prefix-p " *helm" (buffer-name buf))
					 (string-prefix-p "*helm" (buffer-name buf))
					 (string-prefix-p "*Compile" (buffer-name buf))
					 (string-prefix-p " *autoload" (buffer-name buf))
					 (string-prefix-p " *which-key" (buffer-name buf))
					 (string-prefix-p " *temp" (buffer-name buf))
					 )))
             (buffer-list))
	 ))
  (when (region-active-p)
	(helm-multi-occur-1
	 ;;(cl-delete-if (lambda (buffer) (find (aref (buffer-name buffer) 0) " *")) (buffer-list))
	 (seq-filter (lambda (buf)
			   (not (or
					 (string-prefix-p "*Messages" (buffer-name buf))
					 (string-prefix-p " *Echo" (buffer-name buf))
					 (string-prefix-p " *Minibuf-" (buffer-name buf))
					 (string-prefix-p "*Ibuffer" (buffer-name buf))
					 (string-prefix-p " *helm" (buffer-name buf))
					 (string-prefix-p "*helm" (buffer-name buf))
					 (string-prefix-p "*Compile" (buffer-name buf))
					 (string-prefix-p " *autoload" (buffer-name buf))
					 (string-prefix-p " *which-key" (buffer-name buf))
					 (string-prefix-p " *temp" (buffer-name buf))
					 )))
             (buffer-list))
	 (buffer-substring-no-properties (region-beginning) (region-end)))))



;;;;;;origin defun;;;;;;;;;;
(defun helm-search-text-in-all-buffers()
  (interactive)
  (require 'cl)
  (require 'helm-occur)
  (unless (region-active-p)
	(helm-multi-occur-1 (cl-delete-if (lambda (buffer) (find (aref (buffer-name buffer) 0) " *")) (buffer-list))))
  (when (region-active-p)
	(helm-multi-occur-1
	 (cl-delete-if (lambda (buffer) (find (aref (buffer-name buffer) 0) " *")) (buffer-list))
	 (buffer-substring-no-properties (region-beginning) (region-end)))))

