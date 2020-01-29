;;helm occur search multi buffer

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

