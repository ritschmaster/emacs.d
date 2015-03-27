;;; package --- Summary:
;;; Commentary:
;;; Code:

;;------------------------------------------------------------------------------
;; octave-mode
;;------------------------------------------------------------------------------
(require 'octave-mod)
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;;------------------------------------------------------------------------------
;; ac-octave
;;------------------------------------------------------------------------------
(require-package 'ac-octave)
(require 'ac-octave)
(add-to-list 'ac-sources 'ac-source-octave)
(add-hook 'octave-mode-hook '(lambda () (ac-octave-mode-setup)))

(provide 'init-octave)
;;; init-octave ends here
