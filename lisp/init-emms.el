(require-package 'emms)

(require 'emms-setup)
(emms-standard)
(emms-default-players)

(setq emms-score-file "~/.emacs.d/emms/scores"
      emms-stream-bookmarks-file "~/.emacs.d/emms/emms-streams"
      emms-history-file "~/.emacs.d/emms/emms-history"
      emms-cache-file "~/.emacs.d/emms/emms-cache"
      emms-source-file-default-directory "~/Music")

(setq emms-score-enabled-p t
      emms-browser-default-browse-type 'info-album
      emms-stream-default-action "play")

(emms-mode-line-enable)

(provide 'init-emms)
