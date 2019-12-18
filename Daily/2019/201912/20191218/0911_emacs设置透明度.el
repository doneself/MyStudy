;;emacs设置透明度

(global-set-key [(f7)] 'loop-alpha)
(setq alpha-list '((100 100) (95 95) (85 85) (75 75) (65 65)))

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
	   (message (format "Alpha:%d,Alpha background:%d" a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
)
