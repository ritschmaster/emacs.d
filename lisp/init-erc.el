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
(require 'znc)

(add-hook
 'erc-before-connect
 #'(lambda (&rest args)
     (dolist (server znc-servers)
       (let ((server-name (first server))
             (server-port (second server)))
         (dolist (login (fourth server))
           (let ((user (second login)))
             (setf (third login)
                   (offlineimap-get-password server-name
                                             (number-to-string server-port)
                                             user))))))))

(provide 'init-erc)
;;; init-erc ends here
