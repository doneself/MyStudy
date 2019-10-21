;;emacs markdown insert header

;;正式版
(defun markdown-insert-header()
  (interactive)
  (require 'subr-x)
  (let ((current-line-str (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
	(when (string-empty-p current-line-str)
	  (insert "# "))
	(unless (string-blank-p current-line-str)
	  (save-excursion
		(beginning-of-line)
		(if (string= "#" (substring current-line-str 0 1))
			(insert "#")
		(insert "# ")))
	  )))

(defun markdown-insert-header ()
  (interactive)
  (require 'subr-x)
  (if (string-empty-p (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
	  (insert "# "))
  (let ((first-char (buffer-substring-no-properties (line-beginning-position) (+ 1 (line-beginning-position)))))
	(save-excursion
	  (if (string= first-char "#")
		  (progn
			(beginning-of-line)
			(insert "#"))
		(progn
		  (beginning-of-line)
		  (insert "# "))))))


(defun markdown-insert-my-header()
  (interactive)
  (require 'subr-x)
  (newline t)
  (if (string= "" (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
	  (insert "aaa")))

(defun markdown-insert-header ()
  (interactive)
  (require 'subr-x)
  (if (string-empty-p (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
	  (insert "# ")
	(progn
	  (let ((first-char (buffer-substring-no-properties (line-beginning-position) (+ 1 (line-beginning-position)))))
	(save-excursion
	  (if (string= first-char "#")
		  (progn
			(beginning-of-line)
			(insert "#"))
		(progn
		  (beginning-of-line)
		  (insert "# "))))))))


(defun markdown-insert-header ()
  (interactive)
  (require 'subr-x)
  (when (= (line-beginning-position) (line-end-position))
	  (insert "# "))
  (let ((first-char (buffer-substring-no-properties (line-beginning-position) (+ 1 (line-beginning-position)))))
	(save-excursion
	  (if (string= first-char "#")
		  (progn
			(beginning-of-line)
			(insert "#"))
		(progn
		  (beginning-of-line)
		  (insert "# "))))))


(defun markdown-insert-header()
  (interactive)
  (let ((current-line-str (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
	(when (string-empty-p current-line-str)
	  (insert "# "))
	(unless (string-blank-p current-line-str)
	  (beginning-of-line)
	  (if (string= "#" (substring current-line-str 0 1))
		  (insert "#")
		(insert "# ")))))
