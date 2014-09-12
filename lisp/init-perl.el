(require 'cperl-mode)
(require-package 'perl-completion)
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

(add-to-list 'cperl-mode-hook
             '(lambda ()
                (turn-on-eldoc-mode)
                (perl-completion-mode t)
                (add-to-list 'ac-sources 'ac-source-perl-completion)))

(require-package 'plsense)
;; Key binding
(setq plsense-popup-help-key "C-:")
(setq plsense-display-help-buffer-key "M-:")
(setq plsense-jump-to-definition-key "C->")

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "plsense")

;; Do setting recommemded configuration
(plsense-config-default)

(provide 'init-perl)
