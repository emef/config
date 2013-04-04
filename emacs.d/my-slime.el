;;; slime
(require 'slime)
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            (define-key slime-mode-map (kbd "M-n") 'forward-char)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(slime-setup '(slime-repl))

(provide 'my-slime)
