(require-package 'emms)

(require 'emms-setup)
(require 'emms-browser)
(emms-standard)

(defvar *fixed-emms-change-amount* 10)

(setq emms-score-file "~/.emacs.d/emms/scores"
      emms-stream-bookmarks-file "~/.emacs.d/emms/emms-streams"
      emms-history-file "~/.emacs.d/emms/emms-history"
      emms-cache-file "~/.emacs.d/emms/emms-cache"
      emms-source-file-default-directory "~/Music")

(setq emms-score-enabled-p t
      emms-browser-default-browse-type 'info-album
      emms-stream-default-action "play")

(defun my-track-describtion-function (track)
  (let* ((empty "...")
         (name (emms-track-name track))
         (type (emms-track-type track))
         (play-count (or (emms-track-get track 'play-count) 0))
         (last-played (or (emms-track-get track 'last-played) '(0 0 0)))
         (artist (or (emms-track-get track 'info-artist) empty))
         (year (emms-track-get track 'info-year))
         (playing-time (or (emms-track-get track 'info-playing-time) 0))
         (min (/ playing-time 60))
         (sec (% playing-time 60))
         (album (or (emms-track-get track 'info-album) empty))
         (tracknumber (emms-track-get track 'info-tracknumber))
         (short-name (file-name-sans-extension
                      (file-name-nondirectory name)))
         (title (or (emms-track-get track 'info-title) short-name))
         (rating (emms-score-get-score name))
         (rate-char ?\u2665))
    (format "%2s. %20s - %20s - %20s |%2d%s"
            tracknumber
            (substring title
                       0
                       (min 20 (length title)))
            (substring album
                       0
                       (min 20 (length album)))
            (substring artist
                       0
                       (min 20 (length artist)))
            play-count
            (make-string rating rate-char))))

(setq emms-track-description-function 'my-track-describtion-function)

(require 'emms-mode-line)
(require 'emms-playing-time)
(defun my-mode-line-function ()
  (let* ((track (emms-playlist-current-selected-track))
         (empty "...")
         (name (emms-track-name track))
         (short-name (file-name-sans-extension
                      (file-name-nondirectory name)))
         (title (or (emms-track-get track 'info-title) short-name))
         (artist (emms-track-get track 'info-artist))
         (playing-time (or (emms-track-get track 'info-playing-time) 0))

         (line-string ""))
    ;; (if (not (null artist))
    ;;     (setq line-string (concat line-string (format "%s - " artist))))
    (setq line-string (concat line-string (format "%s"
                                                  (substring
                                                   title
                                                   0
                                                   (min 20 (length title))))))
    (format emms-mode-line-format line-string)))

(setq emms-mode-line-mode-line-function 'my-mode-line-function)

(emms-mode-line-enable)
(emms-playing-time 1)

(require 'emms-score)
(emms-score-enable)

(setq emms-volume-change-amount 5)
(defun emms-volume-change-by-fixed-amount (lower-or-raise-func)
  (interactive)
  (let ((old-volume-amount emms-volume-change-amount))
    (setq emms-volume-change-amount *fixed-emms-change-amount*)
    (funcall lower-or-raise-func)
    (setq emms-volume-change-amount old-volume-amount)))


;;; mpd setup
(require 'emms-player-mpd)
(add-to-list 'emms-info-functions 'emms-info-mpd)
(add-to-list 'emms-player-list 'emms-player-mpd)
(setq emms-player-mpd-music-directory emms-source-file-default-directory)

;;; set the available players
; (setq emms-player-list '(emms-player-mplayer emms-player-mpd))

(provide 'init-emms)
