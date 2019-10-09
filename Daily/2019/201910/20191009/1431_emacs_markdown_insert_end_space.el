;;emacs markdown insert end space
(defun markdown-insert-two-space()
  (interactive)
  (require 'subr-x)
  (if (region-active-p)
	  (progn
		(let ((p1 (region-beginning)) (p2 (region-end))
			  (beginLineNum (line-number-at-pos (region-beginning)))
			  (endLineNum (line-number-at-pos (region-end)))
			  (currentLineNum (line-number-at-pos (region-beginning))))
		  (save-excursion
			(goto-char p1)
			(while (<= currentLineNum endLineNum)
			  (unless (string-blank-p (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
				(progn
				  (end-of-line)
				  (insert "  ")))
			  (next-line)
			  (setq currentLineNum (+ currentLineNum 1))))))
	(progn
	  (end-of-line)
	  (insert "  "))))
