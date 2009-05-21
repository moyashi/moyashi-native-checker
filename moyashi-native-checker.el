;; http://taiyaki.org/elisp/urlencode/src/urlencode.el
;; Please install urlencode.el If you haven't it.

(when (load "urlencode" t)
  (defun moyashi-native-checker(arg)
	(interactive "P")
	(let* ((p (point))
		   (m (if mark-active
				  (mark)
				p))
		   (beg (min p m))
		   (end (max p m))
		   (act (if arg "activate" ""))
		  (buf (buffer-substring-no-properties beg end)))
	  (progn
		(while (string-match "\n" buf)
		  (substring buf (match-beginning 0) (match-end 0))
		  (setq buf (replace-match "" t t buf)))
		(if (functionp 'do-applescript)
			(do-applescript (concat "
tell application \"Safari\"\n"
 act
"\nif (count of document) is 0 then
make new document
end if
tell document 1
set URL to \"http://native-checker.com/?q="
(urlencode buf 'utf-8)
"\"
end tell\nend tell"))
(browse-url (concat "http://native-checker.com/?q=" (urlencode buf 'utf-8)))
))))
(global-set-key "\C-cn" 'moyashi-native-checker))
