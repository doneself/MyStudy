emacs lisp 遍历文件夹所有文本

(mapcar (lambda(item) (insert (format "\n%s" item))) (directory-files-recursively "d:/Zero/MyDocument/Note/" "[(\\.txt$)(\\.org$)]"))

(rx "." (or "org" "md" "txt"))

(mapcar (lambda(item) (insert (format "\n%s" item)))(directory-files-recursively "D:/ZerOne/MyMemo" "\\.\\(?:org\\|txt\\)$"))
