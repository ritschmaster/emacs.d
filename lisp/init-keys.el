;;----------------------------------------------------------------------------
;; rename file and buffer
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> r") 'rename-this-file-and-buffer)

;;----------------------------------------------------------------------------
;; comments
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> <f11>") 'comment-or-uncomment-region)

;;----------------------------------------------------------------------------
;; compile
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> <f5>") 'recompile)

;;----------------------------------------------------------------------------
;; gnus
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> G") 'gnus)
(global-set-key (kbd "<f2> s") 'smtpmail-send-queued-mail)

;;----------------------------------------------------------------------------
;; w3m
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> w") 'w3m)
(global-set-key (kbd "<f2> S") 'w3m-search)
(global-set-key (kbd "<f2> U") 'w3m-goto-url)
(define-key w3m-mode-map (kbd "C-c C-u") 'w3m-browse-url-new-tab)
(define-key w3m-mode-map (kbd "C-c C-y") 'w3m-yt-view)

;;----------------------------------------------------------------------------
;; ispell
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> c") 'ispell)
(global-set-key (kbd "<f2> C") 'ispell-change-dictionary)

;;----------------------------------------------------------------------------
;; c-mode & c++-mode
;;----------------------------------------------------------------------------
(define-key c-mode-map (kbd "<f2> <f4>") 'ff-get-other-file)
(define-key c++-mode-map (kbd "<f2> <f4>") 'ff-get-other-file)

;; ;;----------------------------------------------------------------------------
;; ;; ECB
;; ;;----------------------------------------------------------------------------
;; ;; quick navigation between ecb windows
;; (global-set-key (kbd "C-*") 'ecb-goto-window-edit)
;; (global-set-key (kbd "C-+") 'ecb-goto-window-directories)
;; (global-set-key (kbd "C-#") 'ecb-goto-window-sources)
;; (global-set-key (kbd "C-@") 'ecb-goto-window-methods)
;; (global-set-key (kbd "C-!") 'ecb-goto-window-compilation)

;; show/hide ecb window
(global-set-key (kbd "C-x C-;") 'ecb-show-ecb-windows)
(global-set-key (kbd "C-x C-'") 'ecb-hide-ecb-windows)


;;----------------------------------------------------------------------------
;; EMMS
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-c s E") 'emms)
(global-set-key (kbd "C-c s +") 'emms-volume-raise)
(global-set-key (kbd "C-c s -") 'emms-volume-lower)
(global-set-key (kbd "C-c s <left>")
                (lambda ()
                  (interactive)
                  (emms-volume-change-by-fixed-amount 'emms-volume-lower)))
(global-set-key (kbd "C-c s <right>")
                (lambda ()
                  (interactive)
                  (emms-volume-change-by-fixed-amount 'emms-volume-raise)))
(global-set-key (kbd "C-c s RET") 'emms-start)
(global-set-key (kbd "C-c s s") 'emms-stop)
(global-set-key (kbd "C-c s P") 'emms-pause)
(global-set-key (kbd "C-c s n") 'emms-next)
(global-set-key (kbd "C-c s p") 'emms-previous)
(global-set-key (kbd "C-c s h") 'emms-shuffle)
(global-set-key (kbd "C-c s l") 'emms-add-playlist)
(global-set-key (kbd "C-c s L") 'emms-play-playlist)
(global-set-key (kbd "C-c s u") 'emms-score-up-playing)
(global-set-key (kbd "C-c s d") 'emms-score-down-playing)
(global-set-key (kbd "C-c s r") 'emms-toggle-repeat-track)
(global-set-key (kbd "C-c s R") 'emms-toggle-repeat-playlist)
(global-set-key (kbd "C-c s f") 'emms-add-find)
(global-set-key (kbd "C-c s c") 'emms-show)
(global-set-key (kbd "C-c s >") 'emms-seek-forward)
(global-set-key (kbd "C-c s <") 'emms-seek-backward)
(global-set-key (kbd "C-c s k") 'soundklaus-tracks)


;;----------------------------------------------------------------------------
;; Sauron
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-c d s") 'sauron-toggle-hide-show)

;;----------------------------------------------------------------------------
;; org-mode
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> g") 'gtd)
(global-set-key (kbd "<f2> t") 'remember)
(global-set-key (kbd "<f2> n") 'notes)


;;------------------------------------------------------------------------------
;; dired
;;------------------------------------------------------------------------------
(define-key dired-mode-map (kbd "C-x m") 'dired-w3m-find-file)

(provide 'init-keys)
