;;emacs lisp interactive options

(defun select-something (option option1)
  (interactive
   (list
	(completing-read "select first something:" (list "aaa" "bbbb" "cccc"))
		(completing-read "select second something:" (list "aaa" "bbbb" "cccc"))
	))
  (message (format "first selected is %s, second selected is %s" option option1)))


(defun my-select-something (option)
  (interactive
   (list
	(completing-read "select first something:" (list "aaa" "bbbb" "cccc"))
	))
  (message (format "You selected is %s" option)))
