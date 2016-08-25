;;; package --- Summary:

;;; Commentary:
;; This file sets up the C/C++ Mode in Emacs. It adds directories for
;; semantic to extend the auto completion. Please run the function
;; "customize-group init-cc" to change the directories in which this
;; init file should look for C/C++ header files.

;;; Code:
(require 'semantic)
(require 'semantic/bovine/c)

;; semantic autocomplete integration
(add-to-list 'ac-sources 'ac-source-semantic)


;;------------------------------------------------------------------------------
;;------------------------------------------------------------------------------
;; C Setup
;;------------------------------------------------------------------------------
;;------------------------------------------------------------------------------
(require-package 'ac-c-headers)

;;------------------------------------------------------------------------------
;; Use GTK3 Headers:
;;------------------------------------------------------------------------------
(defcustom c-semantic-gtk3-include-directory "/usr/include/gtk-3.0"
  "The path to the GTK3 include directory. It should NOT be terminated with a slash."
  :type '(string)
  :group 'init-cc)
;; (add-to-list 'auto-mode-alist
;;              '(c-semantic-gtk3-include-directory . c-mode))
(semantic-add-system-include c-semantic-gtk3-include-directory 'c-mode)
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file
;;              (concat
;;               c-semantic-gtk3-include-directory
;;               "/gtk.h"))

;;------------------------------------------------------------------------------
;; Use SDL2 Headers:
;;------------------------------------------------------------------------------
(defcustom c-semantic-sdl2-include-directory "/usr/include/sdl2"
  "The path to the SDL2 include directory. It should NOT be terminated with a slash."
  :type '(string)
  :group 'init-cc)
;; (add-to-list 'auto-mode-alist
;;              '(c-semantic-gtk3-include-directory . c-mode))
(semantic-add-system-include c-semantic-sdl2-include-directory 'c-mode)
(semantic-add-system-include c-semantic-sdl2-include-directory 'c++-mode)
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file
;;              (concat
;;               c-semantic-gtk3-include-directory
;;               "/gtk.h"))

;;------------------------------------------------------------------------------
;;------------------------------------------------------------------------------
;; C++ Setup
;;------------------------------------------------------------------------------
;;------------------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))

;;------------------------------------------------------------------------------
;; Use Qt Headers:
;;------------------------------------------------------------------------------
(defcustom cc-semantic-qt-include-directory "/usr/include/Qt"
  "The path to the Qt include directory. It should NOT be terminated with a slash."
  :type '(string)
  :group 'init-cc)
;; (add-to-list 'auto-mode-alist
;;              '(cc-semantic-qt-include-directory . c++-mode))
(semantic-add-system-include cc-semantic-qt-include-directory 'c++-mode)
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat cc-semantic-qt-include-directory "/qconfig.h"))
;; (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat cc-semantic-qt-include-directory "/qconfig-dist.h"))



;; ;;------------------------------------------------------------------------------
;; ;; Use GTK3mm Headers:
;; ;;------------------------------------------------------------------------------
;; (defcustom cc-semantic-gtk3mm-include-directory "/usr/include/gtk-3.0"
;;   "The path to the GTK3 include directory. It should NOT be terminated with a slash."
;;   :type '(string)
;;   :group 'init-cc)
;; (add-to-list 'auto-mode-alist
;;              '(cc-semantic-gtk3mm-include-directory . c++-mode))
;; (semantic-add-system-include cc-semantic-gtk3mm-include-directory 'c++-mode)

(provide 'init-cc)
;;; init-cc ends here
