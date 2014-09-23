(require-package 'emms)

(require 'emms-setup)
(emms-standard)
(emms-default-players)

(defvar *fixed-emms-change-amount* 10)

(setq emms-score-file "~/.emacs.d/emms/scores"
      emms-stream-bookmarks-file "~/.emacs.d/emms/emms-streams"
      emms-history-file "~/.emacs.d/emms/emms-history"
      emms-cache-file "~/.emacs.d/emms/emms-cache"
      emms-source-file-default-directory "~/Music"
      emms-source-playlist "~/Playlists")

(setq emms-score-enabled-p t
      emms-browser-default-browse-type 'info-album
      emms-stream-default-action "play")

(require 'emms-mode-line)
(emms-mode-line 1)

(require 'emms-playing-time)
(emms-playing-time 1)

(require 'emms)
(defun emms-volume-change-by-fixed-amount (lower-or-raise-func)
  (interactive)
  (let ((old-volume-amount emms-volume-change-amount))
    (setq emms-volume-change-amount *fixed-emms-change-amount*)
    (funcall lower-or-raise-func)
    (setq emms-volume-change-amount old-volume-amount)))

(provide 'init-emms)
