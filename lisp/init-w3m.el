(require-package 'w3m)
(require 'w3m)
; use w3m as standard browser of emacs:
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

(defun w3m-browse-url-new-tab ()
   (interactive)
   (let ((url (or (w3m-anchor) (w3m-image))))
     (w3m-copy-buffer nil nil nil t)
     (w3m-browse-url url)))

;; (setq browse-url-browser-function 'w3m-browse-url-new-tab)
(setq w3m-default-display-inline-images t)

(defun dired-w3m-find-file ()
   (interactive)
   (require 'w3m)
   (let ((file (dired-get-filename)))
     (if (y-or-n-p (format "Open 'w3m' %s " (file-name-nondirectory file)))
         (w3m-find-file file))))

(defun w3m-yt-view ()
  "View a YouTube link with youtube-dl and mplayer."
  (interactive)
  (let ((url (or (w3m-anchor) (w3m-image))))
    (string-match "[^v]*v.\\([^&]*\\)" url)
    (start-process "vlc" nil "vlc" url)))

(provide 'init-w3m)
