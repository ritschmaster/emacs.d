;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; erc easy set up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'erc)
(setq erc-prompt-for-password t)
(setq erc-current-nick-highlight-type 'all)
(defun start-irc ()
  "This allows the connection to an IRC server which is already specified. It uses the ~/.authinfo file."
  (interactive)
  (erc-tls))

(require-package 'znc)

(provide 'init-erc)
;;; init-erc ends here
