(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap")

;(global-set-key (kbd "RET") (lambda ()
;                              (interactive)
;                              (newline)
;                              (indent-according-to-mode)))
(define-key my-keys-minor-mode-map (kbd "M-'") 'fill-paragraph)
(define-key my-keys-minor-mode-map (kbd "C-r") (lambda ()
                              (interactive)
                              (move-end-of-line 1)
                              (newline)))
(define-key my-keys-minor-mode-map (kbd "C-M-r") (lambda ()
                                                   (interactive)
                                                   (move-beginning-of-line 1)
                                                   (newline)
                                                   (previous-line)))
(define-key my-keys-minor-mode-map (kbd "C-e") (lambda ()
                              (interactive)
                              (move-beginning-of-line 1)
                              (kill-whole-line 1)
                              (indent-according-to-mode)))
(define-key my-keys-minor-mode-map [f1] 'save-buffer)
(define-key my-keys-minor-mode-map [f2] 'kmacro-end-and-call-macro)
(define-key my-keys-minor-mode-map [f4] 'find-file)
(define-key my-keys-minor-mode-map [f3] 'other-window)
(define-key my-keys-minor-mode-map [f5] 'ido-switch-buffer)
(define-key my-keys-minor-mode-map (kbd "M-d") 'backward-char)
(define-key my-keys-minor-mode-map (kbd "M-h") 'next-line)
(define-key my-keys-minor-mode-map (kbd "C-M-h") 'forward-paragraph)
(define-key my-keys-minor-mode-map (kbd "M-t") 'previous-line)
(define-key my-keys-minor-mode-map (kbd "C-M-t") 'backward-paragraph)
(define-key my-keys-minor-mode-map (kbd "M-n") 'forward-char)
(define-key my-keys-minor-mode-map (kbd "M-u") 'forward-word)
(define-key my-keys-minor-mode-map (kbd "M-.") 'move-end-of-line)
(when window-system
  (define-key my-keys-minor-mode-map (kbd "C-.") 'move-end-of-line))
(define-key my-keys-minor-mode-map (kbd "C-d") 'backward-sexp)
(define-key my-keys-minor-mode-map (kbd "C-l") 'goto-line)
(define-key my-keys-minor-mode-map (kbd "C-p") 'isearch-backward)
(define-key my-keys-minor-mode-map (kbd "M-r") 'comint-history-isearch-backward-regexp)
;(define-key my-keys-minor-mode-map (kbd "M-r") 'isearch-backward-regexp)
(define-key my-keys-minor-mode-map (kbd "M-g") 'mark-paragraph)
(define-key my-keys-minor-mode-map (kbd "M-1") 'select-current-line)
(define-key my-keys-minor-mode-map (kbd "M-2") 'select-current-word)
(define-key my-keys-minor-mode-map (kbd "M-3") 'comment-dwim)

(define-key my-keys-minor-mode-map (kbd "C-x C-M->") 'find-tag) ; bind to some unused placeholder
(define-key my-keys-minor-mode-map (kbd "C-f") (kbd "C-x C-M-> <return>"))

(define-key lisp-mode-map (kbd "M-<up>") 'slime-repl-previous-input)
(define-key lisp-mode-map (kbd "M-<down>") 'slime-repl-next-input)

(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

(defun select-current-word ()
  "Select the word under cursor.
“word” here is considered any alphanumeric sequence with “_” or “-”."
  (interactive)
  (let (pt)
    (skip-chars-backward "-_A-Za-z0-9")
    (setq pt (point))
    (skip-chars-forward "-_A-Za-z0-9")
    (set-mark pt)))

(define-minor-mode my-keys-minor-mode
  "A minor mode to override major mode keybindings"
  t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;;;default minor modes
(my-keys-minor-mode 1)

(provide 'my-keys)
