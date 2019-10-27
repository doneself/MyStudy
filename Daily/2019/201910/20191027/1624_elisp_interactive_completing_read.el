elisp interactive completing read

(defun select-some-thing (someone sometwo)
  (interactive
   (list (completing-read "select one:" '("aaa" "cccc"))
		 (completing-read "select two:" '("hhhhh" "jjjjj"))))
  (message (format "your select is %s and %s." someone sometwo)))
