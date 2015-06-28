(require-package 'sauron)
(setq sauron-separate-frame nil)

(setq sauron-hide-mode-line nil)

(add-hook 'sauron-event-added-functions
          (lambda (origin prio msg &optional props)
            (sauron-fx-sox "~/.emacs.d/src/beep.ogg")))

(sauron-start)

(provide 'init-sauron)
