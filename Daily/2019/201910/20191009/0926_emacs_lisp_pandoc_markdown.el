;;emacs lisp pandoc markdown

(defun pandoc-markdown-to-html-and-open ()
  "Use pandoc to convert markdown to html and open it"
  (interactive)
  (let* (
		 (newFileName (format "%s.html" (file-name-sans-extension (buffer-name))))
		 (currentBufferName (buffer-name))
		 (save-buffer)
		 (print (shell-command-to-string (format "pandoc -f markdown -t html5 %s -o %s" currentBufferName newFileName)))
		 )
		 (w32-shell-execute "open" (format "%s%s" default-directory newFileName) )
	)
  )


(defun pandoc-markdown-to-html-to-browse ()
  "Use pandoc to convert markdown to html and open it"
  (interactive)
  (let* ((newFileName (format "%s.html" (file-name-sans-extension (buffer-name))))
		 (currentBufferName (buffer-name))
		 (css-path "c:/Users/lok/.emacs.d/pandocStyle/github.css"))
	(save-buffer)
	(async-shell-command (format "pandoc -f markdown -t html5 --highlight-style=haddock --css=%s --self-contained  %s -o %s && %s" css-path  currentBufferName newFileName newFileName)
						 "*Async Shell Command*")))


(defun pandoc-markdown-to-docx-current ()
  "Using pandoc convert markdown to docx."
  (interactive)
  (let* (
		 (newFileName (format "%s.docx" (file-name-sans-extension (buffer-name))))
		 (currentBufferName (buffer-name))
		 (css-path "c:/Users/lok/.emacs.d/pandocStyle/github.css"))
		 (save-buffer)
		 (print (shell-command-to-string (format "pandoc -f markdown -t docx --highlight-style=haddock --css=%s --self-contained  %s -o %s" css-path currentBufferName newFileName)))		 
	)
  )


(defun pandoc-markdown-to-html-and-open ()
  "Use pandoc to convert markdown to html and open it"
  (interactive)
  (let* (
		 (newFileName (format "%s.html" (file-name-sans-extension (buffer-name))))
		 (currentBufferName (buffer-name))
		 (output-file (concat (file-name-as-directory my-today-path) newFileName))
		 (css-path "c:/Users/lok/.emacs.d/pandocStyle/github.css"))
	(save-buffer)
	(unless (file-directory-p my-today-path)
	  (make-directory my-today-path t))
	(print (shell-command-to-string (format "pandoc -f markdown -t html5 --highlight-style=haddock --css=%s --self-contained  %s -o %s" css-path currentBufferName output-file)))
	(w32-shell-execute "open" output-file )))
