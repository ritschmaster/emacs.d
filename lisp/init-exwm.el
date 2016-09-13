;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; exwm setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defcustom enable-exwm nil
  "Non nil will enable the loading of EXWM and its config."
  :type 'boolean
  :group 'init-exwm)

(when enable-exwm
  (require-package 'exwm)
  (require 'exwm)
  (setq exwm-workspace-number 8))

(provide 'init-exwm)
;;; init-exwm ends here
