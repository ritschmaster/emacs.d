(require-package 'csharp-mode)

(defun csharp-set-flycheck-command ()
  "Set the flycheck command, dynamically, as a side effect.

This function is intended for use as a before-syntax-check-hook with
flycheck. Use it like this:

(add-hook 'flycheck-before-syntax-check-hook #'csharp-set-flycheck-command)

Then, in your csharp file, specify this in the comments at the header.

// flycheck: gmcs -t:module /debug+ -pkg:dotnet %f

This will cause flycheck to run the given command, replacing the %f with
the source file name."

(and (eq major-mode 'csharp-mode)
     (let ((cmd-string
            (csharp-get-value-from-comments "flycheck" csharp-cmd-line-limit)))
       (and cmd-string
            (not (eq cmd-string ""))
            (let* ((cmd (split-string cmd-string " "))
                   (ferf (member "%f" cmd)))
              (and ferf (setcar ferf 'source))
              (put 'csharp :flycheck-command cmd))))))


(eval-after-load "flycheck"
  '(progn
     (flycheck-define-checker csharp
       "A C# syntax checker for dotnet. By default, it uses the Mono
compiler. If you would like to use a different compiler, see
`csharp-set-flycheck-command'."
       :command ("gmcs" "-target:module" source)
       :error-patterns
       ;; WinFormsHello.cs(17,9): error CS0246: The type or namespace name `derp' could not be found. Are you missing an assembly reference?
       ((error line-start (file-name) "(" line "," column "): error " (message) line-end)
        (warning line-start (file-name) "(" line "," column "): warning " (message) line-end))
       :modes csharp-mode)
     (add-hook 'flycheck-before-syntax-check-hook #'csharp-set-flycheck-command)))

(provide 'init-csharp)
