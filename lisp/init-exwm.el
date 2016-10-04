;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; exwm setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defcustom use-exwm-as-wm nil
  "Non nil will enable the loading of EXWM and its config."
  :type 'boolean
  :group 'init-exwm)

;; (when use-exwm-as-exwm
;;   (require-package 'exwm)
;;   (require 'exwm)
;;   (require 'exwm-config)
;;   (exwm-config-default)
;;   (setq exwm-workspace-number 8))

(provide 'init-exwm)
;;; init-exwm ends here
