;; emacs lisp remove whitespace tab in current line

(defun remove-whitespace-tab-current-line()
  (interactive)
  (let* ((current-line-string (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
		 (replace-string (replace-regexp-in-string "[:*\t ]+" "" current-line-string)))
	(delete-region (line-beginning-position) (line-end-position))
	(insert replace-string)))
