;;----------------------------------------------------------------------------
;; undo-tree
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f9>") 'undo-tree-undo)
(global-set-key (kbd "<f10>") 'undo-tree-redo)

;;----------------------------------------------------------------------------
;; comments
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f11>") 'comment-or-uncomment-region)

;;----------------------------------------------------------------------------
;; compile
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f5>") 'recompile)

;;----------------------------------------------------------------------------
;; c-mode & c++-mode
;;----------------------------------------------------------------------------
(add-hook 'c-mode-hook (lambda ()
                         (local-set-key (kbd "<f8>") 'ff-get-other-file)))
(add-hook 'c++-mode-hook (lambda ()
                           (local-set-key (kbd "<f8>") 'ff-get-other-file)))


;; ;;----------------------------------------------------------------------------
;; ;; ECB
;; ;;----------------------------------------------------------------------------
;; ;; quick navigation between ecb windows
;; (global-set-key (kbd "C-*") 'ecb-goto-window-edit)
;; (global-set-key (kbd "C-+") 'ecb-goto-window-directories)
;; (global-set-key (kbd "C-#") 'ecb-goto-window-sources)
;; (global-set-key (kbd "C-@") 'ecb-goto-window-methods)
;; (global-set-key (kbd "C-!") 'ecb-goto-window-compilation)

;; ;; activate and deactivate ecb
;; (global-set-key (kbd "C-x C-;") 'ecb-activate)
;; (global-set-key (kbd "C-x C-'") 'ecb-deactivate)
;; show/hide ecb window
;; (global-set-key (kbd "C-x C-;") 'ecb-show-ecb-windows)
;; (global-set-key (kbd "C-x C-'") 'ecb-hide-ecb-windows)


;;----------------------------------------------------------------------------
;; EMMS
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f1> r") 'emms-streams)
(global-set-key (kbd "<f1> +") 'emms-volume-raise)
(global-set-key (kbd "<f1> -") 'emms-volume-lower)
(global-set-key (kbd "<f1> RET")'emms-start)
(global-set-key (kbd "<f1> s")'emms-stop)
(global-set-key (kbd "<f1> p")'emms-pause)
(global-set-key (kbd "<f1> >") 'emms-next)
(global-set-key (kbd "<f1> <") 'emms-previous)
(global-set-key (kbd "<f1> h") 'emms-shuffle)

(provide 'init-keys)
