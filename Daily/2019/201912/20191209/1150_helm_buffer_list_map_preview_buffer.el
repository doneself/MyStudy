;;helm buffer list map preview buffer

(define-key helm-map (kbd "<down>")  'VisualizeandGoNextBuffer)      ;; Control-up
(define-key helm-map (kbd "<up>")  'VisualizeandGoPreviousBuffer) ;;Control-down
 
(defun VisualizeandGoNextBuffer ()
  "Helm visualize and select next buffer."
  (interactive)
  (helm-next-line)
  (when (string= helm-buffer "*helm buffers*")
	(helm-execute-persistent-action)))
 
(defun VisualizeandGoPreviousBuffer ()
  "Helm visualize and select previous buffer."
  (interactive)
  (helm-previous-line)
  (when (string= helm-buffer "*helm buffers*")
	(helm-execute-persistent-action)))

