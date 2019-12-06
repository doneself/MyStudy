;;Emacs Lisp生成本周工作日志标题

(defun insert-workreport-file-name ()
  (interactive)
  (let* ((current-time (decode-time))
	   (day (nth 3 current-time))
	   (month (nth 4 current-time))
	   (weekday (nth 6 current-time))
	   (dis-monday (- 1 weekday))
	   (day-seconds 86400)
	   (monday-time (time-add (current-time) (seconds-to-time (* day-seconds dis-monday))))
	   (firday-time (time-add monday-time (seconds-to-time (* day-seconds 4))))
	   )
  (insert (format "本周工作报告%s~%s.txt"
				  (format-time-string "%m-%d" monday-time)
				  (format-time-string "%m-%d" firday-time)))))


(defun goto-workreport-file ()
  (interactive)
  (let* ((work-report-dir "d:/Zero/MyDocument/Note/WorkReports/")
		 (current-time (decode-time))
	   (day (nth 3 current-time))
	   (month (nth 4 current-time))
	   (weekday (nth 6 current-time))
	   (dis-monday (- 1 weekday))
	   (day-seconds 86400)
	   (monday-time (time-add (current-time) (seconds-to-time (* day-seconds dis-monday))))
	   (firday-time (time-add monday-time (seconds-to-time (* day-seconds 4))))
	   (file-name (format "本周工作报告%s~%s.txt"
				  (format-time-string "%m-%d" monday-time)
				  (format-time-string "%m-%d" firday-time)))
	   (file-full-name (concat (file-name-as-directory work-report-dir) file-name))
	   (workreport-file-exist (file-exists-p file-full-name)))
	(when workreport-file-exist
	  (find-file-other-window file-full-name))
	(unless workreport-file-exist
	  (with-temp-buffer
		(insert file-name)
		(write-file file-full-name))
	  (find-file-other-window file-full-name))
  ))
