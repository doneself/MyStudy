;;my default save file defun
(defun my-default-save-directory (path-option)
  (interactive
   (let ((path-options '("StudyDaily" "WorkDaily" "OnlyDaily")))
	 (list (ido-completing-read "Select your convert type: " path-options))))
  (let* (temp-save-dir
		 (this-year (format-time-string "%Y"))
		 (this-month (format-time-string "%Y%m"))
		 (this-day (format-time-string "%Y%m%d")))
	(when (string= path-option "StudyDaily")
	  (setq my-custom-savefile-path (file-name-as-directory
									 (my-join-dirs my-study-dir this-year this-month this-day))))
	(when (string= path-option "WorkDaily")
	  (setq my-custom-savefile-path (file-name-as-directory my-today-path)))
	(when (string= path-option "OnlyDaily")
	  (setq my-custom-savefile-path (file-name-as-directory
									 (my-join-dirs "d:/Zero/MyDocument/Note/MyOnly/" this-year this-month this-day))))
	(message (format "Custom save directory:[%s]" my-custom-savefile-path))))


(defun my-join-dirs (root &rest dirs)
  "Joins a series of directories together, like Python's os.path.join,
  (dotemacs-joindirs \"/tmp\" \"a\" \"b\" \"c\") => /tmp/a/b/c"
  (if (not dirs)
      root
    (apply 'joindirs
           (expand-file-name (car dirs) root)
           (cdr dirs))))
;;It works like so:

(joindirs "e:/tmp" "a" "b")
"/tmp/a/b"
(joindirs "~" ".emacs.d" "src")
"/Users/dbr/.emacs.d/src"
(joindirs "~" ".emacs.d" "~tmp")
"/Users/dbr/.emacs.d/~tmp"

(joindirs "d:/aaa/" "2019/" "201910/" "20191008/")
