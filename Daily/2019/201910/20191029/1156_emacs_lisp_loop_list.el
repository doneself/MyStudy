;;emacs lisp loop list

(setq my-list (list "22" "333" "444"))
(loop for value in my-list
	  do (progn (insert (format "\n%s" value))
				(insert "\n")))
