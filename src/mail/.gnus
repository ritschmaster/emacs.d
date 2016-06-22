;;; package --- Summary
;;; Commentary:
;;; This file should contain your login data for one or several email accounts and your irc username

(defvar smtp-accounts nil)
(setq smtp-accounts
      '((ssl "yourname@yourdomain.somewhere" "smtp.yourdomain.somewhere" 587 "yourname@yourdomain.somewhere" nil)
        (ssl "yourname@otherdomain.somewhereelse" "smtp.otherdomain.somewhereelse" 587 "yourname@otherdomain.somewhereelse" nil)))

; the following enables queing the mail and send all collected
; the mails can then be sent with smtpmail-send-queued-mail
(setq smtpmail-queue-mail t)

; gnus mailboxes
(setq gnus-select-method '(nnmaildir "imapuser1"
                                     (directory "~/Mail/imapuser1")
                                     (directory-files nnheader-directory-files-safe)
                                     (get-new-mail nil)))
(setq gnus-secondary-select-methods '((nnmaildir "imapuser2"
                                                 (directory "~/Mail/imapuser1")
                                                 (directory-files nnheader-directory-files-safe)
                                                 (get-new-mail nil))
                                      (nnml "")))

(setq mail-sources '((pop :server "pop.yourserver.com"
                          :port 995
                          :user "youruser"
                          :stream ssl)))

(setq erc-nick "yourircnick"
      erc-server "yourircserver"
      erc-port 6697)


;;; .gnus ends here
