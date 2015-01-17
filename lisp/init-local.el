;;; This is the init-local of ritsch_master

;; ede
(global-ede-mode)

;; auto-complete-c-headers
(require-package 'auto-complete-c-headers)
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

;; YASnippet
(require-package 'yasnippet)
(require 'yasnippet)
(yas-global-mode 1)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")

;; w3m
(require-package 'w3m)
(require 'w3m)
; use w3m as standard browser of emacs:
;; (setq browse-url-browser-function 'w3m-browse-url)
;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; octave-mode
(require 'octave-mod)
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; ac-octave
(require-package 'ac-octave)
(require 'ac-octave)
(add-to-list 'ac-sources 'ac-source-octave)
(add-hook 'octave-mode-hook '(lambda () (ac-octave-mode-setup)))

;; auctex
(require-package 'auctex)
(require 'tex-mik)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


;;; other packages in this kit:


;;; other configuration
;; ;; semantic set up
;; (require 'semantic/ia)
;; (require 'semantic/bovine/c)
;; (semantic-mode 1)
;; (setq-mode-local c-mode semanticdb-find-default-throttle
;;                       '(project local unloaded system recursive))
;; (setq-mode-local c++-mode semanticdb-find-default-throttle
;;                       '(project local unloaded system recursive))

;; ; semantic autocomplete integration
;; (add-to-list 'ac-sources 'ac-source-semantic)

;; ; enable some modes
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)

;; ;  semantic uses gnu
;; (semanticdb-enable-gnu-global-databases 'c-mode t)
;; (semanticdb-enable-gnu-global-databases 'c++-mode t)

;; ; add Qt to c++-mode
;; (defvar qt-base-dir "/usr/include")
;; (if (file-readable-p qt-base-dir)
;;     (progn
;;       (semantic-add-system-include qt-base-dir 'c++-mode)
;;       (semantic-add-system-include (concat qt-base-dir "/Qt") 'c++-mode)
;;       (semantic-add-system-include (concat qt-base-dir "/QtGui") 'c++-mode)
;;       (semantic-add-system-include (concat qt-base-dir "/QtCore") 'c++-mode)
;;       (semantic-add-system-include (concat qt-base-dir "/QtTest") 'c++-mode)
;;       (semantic-add-system-include (concat qt-base-dir "/QtNetwork") 'c++-mode)
;;       (semantic-add-system-include (concat qt-base-dir "/QtSvg") 'c++-mode)
;;       (add-to-list 'auto-mode-alist (cons qt-base-dir 'c++-mode))
;;       (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt-base-dir "/Qt/qconfig.h"))
;;       (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt-base-dir "/Qt/qconfig-large.h"))
;;       (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt-base-dir "/Qt/qglobal.h"))))

;; ; add Boost to c++-mode
;; (defvar boost-base-dir "/usr/include/boost")
;; (if (file-readable-p boost-base-dir)
;;     (progn
;;       (semantic-add-system-include boost-base-dir 'c++-mode)
;;       (add-to-list 'auto-mode-alist (cons boost-base-dir 'c++-mode))
;;       (add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat boost-base-dir "/config.hpp"))))

(provide 'init-local)
