;;emacs git commit current buffer

(defun git-commit-current-buffer()
  (interactive)
  (when (buffer-file-name)
	(let* ((current-time (format-time-string "%Y-%m-%d %a %H:%M:%S"))
		   (command-str (format "git add -A && git commit -m \"%s%s\"" (buffer-name) current-time)))
	  (async-shell-command command-str))))
