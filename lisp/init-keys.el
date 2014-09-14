;;----------------------------------------------------------------------------
;; ECB
;;----------------------------------------------------------------------------

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

(provide 'init-keys)
