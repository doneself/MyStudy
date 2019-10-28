;;emacs 遍历buffer每一行

(let ((lines '()))
  (goto-char (point-min))
  (while (not (eobp))
	;;(add-to-list 'lines (buffer-substring-no-properties (line-beginning-position) (line-end-position)) t)
	(push (buffer-substring-no-properties (line-beginning-position) (line-end-position)) lines)
	(forward-line 1))
  (with-temp-buffer
	(set-buffer (get-buffer-create "*Temp test*"))
	(erase-buffer)
	(mapcar (lambda(item) (insert (format "\n%s" item))) (nreverse lines))
	(switch-to-buffer-other-window "*Temp test*")))
