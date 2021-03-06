;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)

(dolist (hook (if (fboundp 'prog-mode)
                  '(prog-mode-hook ruby-mode-hook)
                '(find-file-hooks)))
  (add-hook hook 'goto-address-prog-mode))
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(setq goto-address-mail-face 'link)

(setq-default regex-tool-backend 'perl)

(add-auto-mode 'conf-mode "Procfile")

;;----------------------------------------------------------------------------
;; Some great functions for finding the matching parenthesis
;;----------------------------------------------------------------------------
(defun goto-match-paren (arg)
  "Go to the matching if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

(defun goto-matching-ruby-block (arg)
  (cond
   ;; are we at an end keyword?
   ((equal (current-word) "end")
    (ruby-beginning-of-block))
   ;; or are we at a keyword itself?
   ((string-match (current-word) "\\(for\\|while\\|until\\|if\\|class\\|module\\|case\\|unless\\|def\\|begin\\|do\\)")
    (ruby-end-of-block))))


(defun dispatch-goto-matching (arg)
  "Go to the matching if on a parenthesis or something similar, similar to vi style of % "
  (interactive "p")
  (if (or
       (looking-at "[\[\(\{]")
       (looking-at "[\]\)\}]")
       (looking-back "[\[\(\{]" 1)
       (looking-back "[\]\)\}]" 1))

      (goto-match-paren arg)

    (when (eq major-mode 'ruby-mode)
      (goto-matching-ruby-block arg))))

(global-set-key "\M--" 'dispatch-goto-matching)

;;----------------------------------------------------------------------------
;; linum mode for all programming modes and auctex
;;----------------------------------------------------------------------------
(require-package 'linum)
(require 'linum)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'TeX-mode-hook 'linum-mode)

;;----------------------------------------------------------------------------
;; enable hideshow for all programming modes
;;----------------------------------------------------------------------------
(add-hook 'prog-mode-hook 'hs-minor-mode)

;;----------------------------------------------------------------------------
;; disable the menu bar
;;----------------------------------------------------------------------------
(menu-bar-mode -1)

;;----------------------------------------------------------------------------
;;
;;----------------------------------------------------------------------------
(defun next-line-comment ()
  "Inserts a new line and a * when in a comment block. It's like inserting itemizations in org-mode."
  )

;; ;;----------------------------------------------------------------------------
;; ;; compilation setup
;; ;;----------------------------------------------------------------------------
;; (defun brian-compile-finish (buffer outstr)
;;   (unless (string-match "finished" outstr)
;;     (switch-to-buffer-other-window buffer))
;;   t)

;; (setq compilation-finish-functions 'brian-compile-finish)

;; (defadvice compilation-start
;;   (around inhibit-display
;;       (command &optional mode name-function highlight-regexp))
;;   (if (not (string-match "^\\(find\\|grep\\)" command))
;;       (flet ((display-buffer)
;;          (set-window-point)
;;          (goto-char))
;;     (fset 'display-buffer 'ignore)
;;     (fset 'goto-char 'ignore)
;;     (fset 'set-window-point 'ignore)
;;     (save-window-excursion
;;       ad-do-it))
;;     ad-do-it))

;; (ad-activate 'compilation-start)

(require-package 'bookmark+)

;;----------------------------------------------------------------------------
;; Enable UTF-8 everyhwere to avoid ugly mails
;;----------------------------------------------------------------------------
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)

(display-time)

(provide 'init-misc)
