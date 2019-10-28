;;emacs 简单的helm列表生成范例

(setq my-list-result
	  (list
	   "d:/Zero/MyStudy/Daily/2019/201910/20191028/1102_CSS_制作目录.html"
	   "d:/Zero/MyStudy/Daily/2019/201910/20191028/1447_emacs_遍历buffer每一行.el"))

(defvar helm-my-source
'((name . "my-list")
  (candidate-number-limit . 100)
  (candidates . my-list-result)
  (action . (("Find file " . find-file)
			 ("View file " . view-file)))
))

(helm-other-buffer helm-my-source "*My Helm*")
