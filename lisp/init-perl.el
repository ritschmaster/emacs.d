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

(provide 'init-perl)
