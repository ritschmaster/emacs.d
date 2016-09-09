(require-package 'bind-map)
(defvar emacs-d-default-map (make-sparse-keymap)
  "Base keymap for all keys.")

(bind-map emacs-d-default-map
  :keys ("M-m"))

;;----------------------------------------------------------------------------
;; Buffer specific commands - starting with "b"
;;----------------------------------------------------------------------------
(define-key emacs-d-default-map (kbd "b f") 'rename-this-file-and-buffer)

;;----------------------------------------------------------------------------
;; Code specific commands - starting with "c"
;;----------------------------------------------------------------------------
(define-key emacs-d-default-map (kbd "c l")
  'comment-or-uncomment-region)
(define-key emacs-d-default-map (kbd "c C")
  'compile)
(define-key emacs-d-default-map (kbd "c r")
  'recompile)

;;----------------------------------------------------------------------------
;; applications - starting with "a"
;;----------------------------------------------------------------------------
;;; gnus
(define-key emacs-d-default-map (kbd "a g")
  'gnus)
(define-key emacs-d-default-map (kbd "a S")
  'smtpmail-send-queued-mail)

;;; w3m
(define-key emacs-d-default-map (kbd "a b s") 'w3m)
(define-key emacs-d-default-map (kbd "a b S") 'w3m-search)
(define-key emacs-d-default-map (kbd "a b g") 'w3m-goto-url)
(define-key w3m-mode-map (kbd "C-c C-u") 'w3m-browse-url-new-tab)
(define-key w3m-mode-map (kbd "C-c C-y") 'w3m-yt-view)

;;; EMMS
(define-key emacs-d-default-map (kbd "a m o") 'emms)
(define-key emacs-d-default-map (kbd "a m S") 'emms-start)
(define-key emacs-d-default-map (kbd "a m s") 'emms-stop)
(define-key emacs-d-default-map (kbd "a m P") 'emms-pause)
(define-key emacs-d-default-map (kbd "a m p") 'emms-previous)
(define-key emacs-d-default-map (kbd "a m n") 'emms-next)
(define-key emacs-d-default-map (kbd "a m +") 'emms-volume-raise)
(define-key emacs-d-default-map (kbd "a m -") 'emms-volume-raise)
(define-key emacs-d-default-map (kbd "a m *")
  (lambda ()
    (interactive)
    (emms-volume-change-by-fixed-amount 'emms-volume-raise)))
(define-key emacs-d-default-map (kbd "a m _")
  (lambda ()
    (interactive)
    (emms-volume-change-by-fixed-amount 'emms-volume-lower)))
(define-key emacs-d-default-map (kbd "a m l") 'emms-add-playlist)
(define-key emacs-d-default-map (kbd "a m f") 'emms-add-file)
(define-key emacs-d-default-map (kbd "a m F") 'emms-add-find)
(define-key emacs-d-default-map (kbd "a m <") 'emms-seek-backward)
(define-key emacs-d-default-map (kbd "a m >") 'emms-seek-forward)
(define-key emacs-d-default-map (kbd "a m h") 'emms-shuffle)
(define-key emacs-d-default-map (kbd "a m c") 'emms-playlist-clear)

;;; org mode
(define-key emacs-d-default-map (kbd "a o a") 'org-agenda-list)
(define-key emacs-d-default-map (kbd "a o o") 'org-agenda)
(define-key emacs-d-default-map (kbd "a o t") 'org-todo-list)
(define-key emacs-d-default-map (kbd "a o G") 'gtd)
(define-key emacs-d-default-map (kbd "a o R") 'remember)
(define-key emacs-d-default-map (kbd "a o N") 'notes)

;;----------------------------------------------------------------------------
;; spelling - starting with "s"
;;----------------------------------------------------------------------------
(define-key emacs-d-default-map (kbd "s c") 'ispell)
(define-key emacs-d-default-map (kbd "s d") 'ispell-change-dictionary)

;;----------------------------------------------------------------------------
;; c-mode & c++-mode
;;----------------------------------------------------------------------------
;; (define-key c-mode-map (kbd "m g a") 'ff-get-other-file)
;; (define-key c++-mode-map (kbd "m g a") 'ff-get-other-file)
(define-key emacs-d-default-map (kbd "m g a") 'ff-get-other-file)

;;----------------------------------------------------------------------------
;; ECB
;;----------------------------------------------------------------------------
;; quick navigation between ecb windows
;; (define-key ecb-mode-map (kbd "C-*") 'ecb-goto-window-edit1)
;; (define-key ecb-mode-map (kbd "C-+") 'ecb-goto-window-directories)
;; (define-key ecb-mode-map (kbd "C-#") 'ecb-goto-window-sources)
;; (define-key ecb-mode-map (kbd "C-@") 'ecb-goto-window-methods)
;; (define-key ecb-mode-map (kbd "C-!") 'ecb-goto-window-compilation)

;; ;; show/hide ecb window
;; (global-set-key (kbd "C-x C-;") 'ecb-show-ecb-windows)
;; (global-set-key (kbd "C-x C-'") 'ecb-hide-ecb-windows)

;; ;;----------------------------------------------------------------------------
;; ;; Sauron
;; ;;----------------------------------------------------------------------------
;; (global-set-key (kbd "C-c d s") 'sauron-toggle-hide-show)

;; ;;------------------------------------------------------------------------------
;; ;; dired
;; ;;------------------------------------------------------------------------------
;; (define-key dired-mode-map (kbd "C-x m") 'dired-w3m-find-file)

;;------------------------------------------------------------------------------
;; message-mode
;;------------------------------------------------------------------------------
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key "C-c M-o" 'org-mime-htmlize)))

(provide 'init-keys)
