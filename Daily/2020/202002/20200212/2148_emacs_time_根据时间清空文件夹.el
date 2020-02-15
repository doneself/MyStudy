;;emacs time practice
;;2148_emacs_time_根据时间清空文件夹.el


(let* (
	   (now (decode-time))
	   (minute (nth 1 now))
	   (hour (nth 2 now))
	   (time-seconds (- 0 (* 60 minute) (* 60 60 hour)))
	   (time-zero (time-add (current-time) (seconds-to-time time-seconds)))
	   )
  (decode-time time-zero))


(defun yesterday-time-p (time)
  (let* (
	   (now (decode-time))
	   (minute (nth 1 now))
	   (hour (nth 2 now))
	   (time-seconds (- 0 (* 60 minute) (* 60 60 hour)))
	   (time-zero (time-add (current-time) (seconds-to-time time-seconds)))
	   )
	(time-less-p time time-zero)))

(yesterday-time-p (current-time))

(defun yesterday-before-file-p (file-path)
  (let* (
	   (now (decode-time))
	   (minute (nth 1 now))
	   (hour (nth 2 now))
	   (time-seconds (- 0 (* 60 minute) (* 60 60 hour)))
	   (time-zero (time-add (current-time) (seconds-to-time time-seconds)))
	   (file-last-access-time (file-attribute-modification-time (file-attributes file-path)))
	   )
	(time-less-p file-last-access-time time-zero)))

(defun clear-yesterday-before-file (dir)
  (let ((file-list (directory-files-recursively dir (rx anything)))
		 )
	(mapcar (lambda(item)
			  (when (yesterday-before-file-p item)
				  (delete-file item))
			  ) file-list)))


(clear-yesterday-before-file "G:/OldFiles/201902/打印图片")
(clear-yesterday-before-file "C:/Users/lok/Desktop/Daily")


(defun clear-yesterday-before-file (dir)
  (let* ((file-list (directory-files-recursively dir (rx anything)))
	   (now (decode-time))
	   (minute (nth 1 now))
	   (hour (nth 2 now))
	   (time-seconds (- 0 (* 60 minute) (* 60 60 hour)))
	   (time-zero (time-add (current-time) (seconds-to-time time-seconds)))
	   )
	(mapcar (lambda(item)
			  (if (time-less-p
					 (file-attribute-modification-time (file-attributes item)) time-zero)
				  (delete-file item))
			  ) file-list)))

(current-time)
(24132 3803 273829 0)
