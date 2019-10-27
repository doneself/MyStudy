;;elisp process the buffer character-by-character

(goto-char (point-min))
(while (not (eobp))
  (let* ((current-character (char-after))
         (new-character (do-something current-character)))
    (delete-char 1)
    (insert-char new-character))
  (forward-char 1))
