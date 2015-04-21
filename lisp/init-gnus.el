;;; package --- Summary:
;;; Commentary:
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; offlineimap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcustom gnus-enable-offlineimap nil
  "Non nil will enable offlineimap and starts it when gnus start."
  :type 'boolean
  :group 'init-gnus)
(when gnus-enable-offlineimap
  (require-package 'offlineimap)
  (add-hook 'gnus-before-startup-hook 'offlineimap))

(require 'netrc)
(defun offlineimap-get-password (host port login)
  "Get the password of a user with login on a host with port."
  (let* ((netrc (netrc-parse "~/.authinfo.gpg")))
    (let ((matches nil))
      (dolist (entry netrc)
        (if (and
             (string= (cdr (elt entry 0)) host)
             (string= (cdr (elt entry 1)) login)
             (string= (cdr (elt entry 3)) port))
            (setq matches (cdr (elt entry 2)))))
      matches)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bbdb set up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'bbdb)
(bbdb-initialize 'gnus 'message)
(bbdb-insinuate-message)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(setq bbdb-file "~/.bbdb-contacts")
(setq bbdb-send-mail-style 'gnus)
(setq bbdb-complete-name-full-completion t)
(setq bbdb-completion-type 'primary-or-name)
(setq bbdb-complete-name-allow-cycling t)
(setq
 bbdb-offer-save 1
 bbdb-use-pop-up t
 bbdb-electric-p t
 bbdb-popup-target-lines  1)

;; bbdb-vard
(require-package 'bbdb-vcard)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gnus set up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'gnus)
(require 'nnir)
(setq gnus-fetch-old-headers t) ; do not hide already read messages
(setq gnus-ignored-newsgroups "")
; set the place where MIME stuff will go
(defvar mime-download-folder "~/Downloads")
(setq mm-default-directory (if (file-readable-p mime-download-folder)
                               mime-download-folder
                             "~/"))
(add-hook 'message-mode-hook 'turn-on-orgstruct) ; Enable features from org-mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smtpmail mutli
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smtpmail)
(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      mail-from-style nil
      smtpmail-debug-info t
      smtpmail-debug-verb t)

(defun set-smtp (mech server port user password)
  "Set related SMTP variables for supplied parameters."
  (setq smtpmail-smtp-server server smtpmail-smtp-service port
        smtpmail-auth-credentials (list (list server port user
                                              password)) smtpmail-auth-supported (list mech)
                                              smtpmail-starttls-credentials nil)
  (message "Setting SMTP server to `%s:%s' for user `%s'."
           server port user))

(defun set-smtp-ssl (server port user password &optional key
                            cert)
  "Set related SMTP and SSL variables for supplied parameters."
  (setq starttls-use-gnutls t
        starttls-gnutls-program "gnutls-cli"
        starttls-extra-arguments nil smtpmail-smtp-server server
        smtpmail-smtp-service port
        smtpmail-auth-credentials (list (list server port user
                                              password)) smtpmail-starttls-credentials (list (list
                                                                                              server port key cert)))
  (message
   "Setting SMTP server to `%s:%s' for user `%s'. (SSL
enabled.)" server port user))

; This function will complain if you fill the from field with
; an account not present in smtp-accounts.
(defun change-smtp ()
  "Change the SMTP server according to the current from line."
  (save-excursion
    (loop with from = (save-restriction
                        (message-narrow-to-headers)
                        (message-fetch-field "from"))
          for (auth-mech address . auth-spec) in smtp-accounts
          when (string-match address from) do (cond
                                               ((memq auth-mech '(cram-md5 plain login))
                                                (return (apply 'set-smtp (cons auth-mech auth-spec))))
                                               ((eql auth-mech 'ssl)
                                                (return (apply 'set-smtp-ssl auth-spec)))
                                               (t (error "Unrecognized SMTP auth. mechanism:
`%s'." auth-mech))) finally (error "Cannot infer SMTP
information."))))

(defvar %smtpmail-via-smtp (symbol-function 'smtpmail-via-smtp))

(defun smtpmail-via-smtp (recipient smtpmail-text-buffer)
  (with-current-buffer smtpmail-text-buffer
    (change-smtp))
  (funcall (symbol-value '%smtpmail-via-smtp) recipient
           smtpmail-text-buffer))

;;----------------------------------------------------------------------------
;; POP3 setup
;;----------------------------------------------------------------------------
(defun set-mail-sources-passwords (sources)
  "Gets the passwords for a list of lists of users (the parameter sources - should be used like mail-sources excluding the field :password) from the ~/.authinfo.gpg file"
  (let* ((netrc (netrc-parse "~/.authinfo.gpg")))
    (dolist (mail-source sources)
              (print (lax-plist-get (rest mail-source) :user))
      (dolist (entry netrc)

        (when (and
             (string= (cdr (elt entry 0))
                      (lax-plist-get (rest mail-source) :server))
             (string= (cdr (elt entry 1))
                      (lax-plist-get (rest mail-source) :user))
             (string= (cdr (elt entry 3))
                      (number-to-string (lax-plist-get (rest mail-source) :port)))
             )
             (lax-plist-put (rest mail-source) :password (cdr (elt entry 2)))))))
  (setq mail-sources sources))

(add-hook 'gnus-before-startup-hook
          (lambda ()
            (when (boundp 'mail-sources)
              (set-mail-sources-passwords mail-sources))))

;;----------------------------------------------------------------------------
;; PGG Encryption
;;----------------------------------------------------------------------------
(require 'pgg)

;; verify/decrypt only if mml knows about the protocl used
(setq mm-verify-option 'known)
(setq mm-decrypt-option 'known)

;; Here we make button for the multipart
(setq gnus-buttonized-mime-types '("multipart/encrypted" "multipart/signed"))

;; Automatically sign when sending mails
(add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)

;; Tells Gnus to inline the part
(add-to-list 'mm-inlined-types "application/pgp$")

;; Tells Gnus how to display the part when it is requested
(add-to-list 'mm-inline-media-tests '("application/pgp$"
                                      mm-inline-text identity))

;; Tell Gnus not to wait for a request, just display the thing
;; straight away.
(add-to-list 'mm-automatic-display "application/pgp$")

;; But don't display the signatures, please.
(setq mm-automatic-display (remove "application/pgp-signature"
                                   mm-automatic-display))

(defcustom gnus-enable-automatic-message-encryption t
  "Non nil enables the automatic encryption of messages within gnus."
  :type 'boolean
  :group 'init-gnus)

;; Automatic signing/encryption if possible
(add-hook
 'message-send-hook
 (lambda ()
   (cond ((message-mail-p)
          (let ((toheader (message-fetch-field "To")))
            (let ((recipient (nth 1 (mail-extract-address-components toheader nil))))
              (message recipient)
              (cond ((and
                      gnus-enable-automatic-message-encryption
                      (and (not (null recipient))
                           (or
                            (pgg-lookup-key recipient)
                            (and
                             (pgg-fetch-key pgg-default-keyserver-address recipient)
                             (pgg-lookup-key recipient)
                             ) ;; we might have added some keys but not the right one ! so we need to check the local base again
                            )
                           ))
                     (mml-secure-message-encrypt-pgpmime))
                    (t
                     (mml-secure-message-sign-pgpmime))))))
         ((message-news-p)
          (mml-secure-message-sign-pgpmime)))))


(provide 'init-gnus)
;;; init-gnus ends here
