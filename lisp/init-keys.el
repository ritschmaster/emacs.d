;;----------------------------------------------------------------------------
;; undo-tree
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f9>") 'undo-tree-undo)
(global-set-key (kbd "<f10>") 'undo-tree-redo)

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
(global-set-key (kbd "<f5>") 'recompile)

;;----------------------------------------------------------------------------
;; c-mode & c++-mode
;;----------------------------------------------------------------------------
(add-hook 'c-mode-hook (lambda ()
                         (local-set-key (kbd "<f2> <f4>") 'ff-get-other-file)))
(add-hook 'c++-mode-hook (lambda ()
                           (local-set-key (kbd "<f2> <f4>") 'ff-get-other-file)))

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
(global-set-key (kbd "C-c s s")'emms-stop)
(global-set-key (kbd "C-c s P")'emms-pause)
(global-set-key (kbd "C-c s n") 'emms-next)
(global-set-key (kbd "C-c s p") 'emms-previous)
(global-set-key (kbd "C-c s h") 'emms-shuffle)
(global-set-key (kbd "C-c s l") 'emms-play-playlist)
(global-set-key (kbd "C-c s u")'emms-score-up-playing)
(global-set-key (kbd "C-c s d")'emms-score-down-playing)
(global-set-key (kbd "C-c s r") 'emms-toggle-repeat-track)
(global-set-key (kbd "C-c s R") 'emms-toggle-repeat-playlist)
(global-set-key (kbd "C-c s f") 'emms-add-find)
(global-set-key (kbd "C-c s >") 'emms-seek-forward)
(global-set-key (kbd "C-c s <") 'emms-seek-backward)

;;----------------------------------------------------------------------------
;; Sauron
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-c d s") 'sauron-toggle-hide-show)

;;----------------------------------------------------------------------------
;; org-mode
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f2> g") 'gtd)

(provide 'init-keys)
