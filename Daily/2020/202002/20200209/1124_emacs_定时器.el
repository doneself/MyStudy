;;emacs 定时器


(defun insert-this-time()
  (with-current-buffer
	  (set-buffer (get-buffer-create "*current-time*"))
	(insert "\n")
  (insert (format-time-string "%Y-%m-%d %a %H:%M:%S")))
  )

;;(insert-this-time)

(run-at-time 0 10 'insert-this-time)
