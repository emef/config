;;;macbook specific settings
(setq mac-command-modifier 'meta)

;;rmtoo 
(load "~/.emacs.d/req-mode.el")

(defvar org-journal-file "~/journal.org"  
  "Path to OrgMode journal file.")  

;;;augment path
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin")) 
(setq exec-path (append exec-path '("/usr/local/gnat/bin/"
                                    "/usr/local/bin"
                                    "/usr/texbin") exec-path))

;(load-file "~/.emacs.d/color-theme-tangotango.el")
(load-file "~/.emacs.d/erc-highlight-nicknames.el")
(load (expand-file-name "~/quicklisp/slime-helper.el"))


(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))


(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap")

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/org/lisp")
(add-to-list 'load-path "~/.emacs.d/org/contrib/lisp")
;(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/erc")
(add-to-list 'load-path "~/.emacs.d/slime/")
(add-to-list 'load-path "/usr/local/lib/erlang/lib/tools-2.6.6.1/emacs/")

(global-set-key (kbd "RET") (lambda ()
                              (interactive)
                              (newline)
                              (indent-according-to-mode)))
(define-key my-keys-minor-mode-map (kbd "M-'") 'fill-paragraph)
(define-key my-keys-minor-mode-map (kbd "C-r") (lambda ()
                              (interactive)
                              (move-end-of-line 1)
                              (newline-and-indent)))
(define-key my-keys-minor-mode-map (kbd "C-M-r") (lambda ()
                                                   (interactive)
                                                   (move-beginning-of-line 1)
                                                   (newline)
                                                   (previous-line)
                                                   (indent-according-to-mode)))
(define-key my-keys-minor-mode-map (kbd "C-e") (lambda ()
                              (interactive)
                              (move-beginning-of-line 1)
                              (kill-whole-line 1)
                              (indent-according-to-mode)))
(define-key my-keys-minor-mode-map [f1] 'save-buffer)
(define-key my-keys-minor-mode-map [f4] 'find-file)
(define-key my-keys-minor-mode-map [f3] 'other-window)
(define-key my-keys-minor-mode-map [f5] 'ido-switch-buffer)
(define-key my-keys-minor-mode-map (kbd "M-d") 'backward-char)
(define-key my-keys-minor-mode-map (kbd "M-h") 'next-line)
(define-key my-keys-minor-mode-map (kbd "M-t") 'previous-line)
(define-key my-keys-minor-mode-map (kbd "M-n") 'forward-char)
(define-key my-keys-minor-mode-map (kbd "M-u") 'forward-word)
(define-key my-keys-minor-mode-map (kbd "C-.") 'move-end-of-line)
(define-key my-keys-minor-mode-map (kbd "C-d") 'backward-sexp)
(define-key my-keys-minor-mode-map (kbd "C-n") 'forward-sexp)
(define-key my-keys-minor-mode-map (kbd "M-p") 'auto-complete)
(define-key my-keys-minor-mode-map (kbd "C-j") 'org-journal-entry)

(define-key lisp-mode-map (kbd "M-<up>") 'slime-repl-previous-input)
(define-key lisp-mode-map (kbd "M-<down>") 'slime-repl-next-input)

;;;; erlang
(setq erlang-root-dir "/usr/local/lib/erlang")
(require 'erlang-start)

;;;; org-mode
(require 'org-install)
(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; word count
(autoload 'word-count-mode "word-count"
  "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

;;;; erc - irc client
(require 'erc)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#lisp" "#ai" "#machinelearning")))
(erc-highlight-nicknames-enable)

;;;; color themes
(require 'color-theme)
(require 'color-theme-tangotango)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-tangotango)))

;;;; snippets
(require 'yasnippet-bundle)

;; awesome auto-complete
(require 'init-auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

;;;;
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;(require 'slime)
(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            (define-key slime-mode-map (kbd "M-n") 'forward-char)))
                            ;(auto-complete-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(slime-setup '(slime-repl))



;;;custom variables
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ac-sources (quote (ac-source-yasnippet ac-source-imenu ac-source-abbrev ac-source-words-in-buffer ac-source-files-in-current-dir ac-source-filename)) t)
 '(doc-view-continuous t)
 '(global-hl-line-mode nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/calendar.org")))
 '(org-export-html-style-include-default nil)
 '(same-window-buffer-names (quote ("*mail*" "*inferior-lisp*" "*ielm*" "*scheme*")))
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))))

(setq-default c-basic-offset 4)

;;line numbers
(require 'setnu)

(require 'ido)
(ido-mode t)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-level-2 ((t (:foreground "chocolate1")))))


;; Custom functions/hooks for persisting/loading frame geometry upon save/load
(defun save-frameg ()
  "Gets the current frame's geometry and saves to ~/.emacs.frameg."
  (let ((frameg-font (frame-parameter (selected-frame) 'font))
        (frameg-left (frame-parameter (selected-frame) 'left))
        (frameg-top (frame-parameter (selected-frame) 'top))
        (frameg-width (frame-parameter (selected-frame) 'width))
        (frameg-height (frame-parameter (selected-frame) 'height))
        (frameg-file (expand-file-name "~/.emacs.frameg")))
    (with-temp-buffer
      ;; Turn off backup for this file
      (make-local-variable 'make-backup-files)
      (setq make-backup-files nil)
      (insert
       ";;; This file stores the previous emacs frame's geometry.\n"
       ";;; Last generated " (current-time-string) ".\n"
       "(setq initial-frame-alist\n"
       "      '((font . \"" frameg-font "\")\n"
       (format "        (top . %d)\n" (max frameg-top 0))
       (format "        (left . %d)\n" (max frameg-left 0))
       (format "        (width . %d)\n" (max frameg-width 0))
       (format "        (height . %d)))\n" (max frameg-height 0)))
      (when (file-writable-p frameg-file)
          (write-file frameg-file)))))

 
(defun load-frameg ()
  "Loads ~/.emacs.frameg which should load the previous frame's geometry."
  (let ((frameg-file (expand-file-name "~/.emacs.frameg")))
    (when (file-readable-p frameg-file)
        (load-file frameg-file))))
 
;; Special work to do ONLY when there is a window system being used
(if window-system
    (progn
      (add-hook 'after-init-hook 'load-frameg)
      (add-hook 'kill-emacs-hook 'save-frameg)))

(defun tex-to-pdf(path)
  (let (new-text)
    (setq new-text
          (replace-regexp-in-string ".tex" ".pdf" path))
    new-text))

(defun latex-view ()
  (let (fname retcode f1)
    (setq f1
          current-frame-configuration)j
    (setq fname
          (tex-to-pdf buffer-file-name))
    (setq retcode
          (shell-command (concat "evince " fname " &")))
    (set-frame-configuration f1)))

(defun latex-save ()
  (interactive)
  (if (buffer-modified-p) (save-buffer))
  (let ((f1 (current-frame-configuration))
        (retcode (shell-command (concat "pdflatex " buffer-file-name))))
    (if (= retcode 0) (set-frame-configuration f1))))


(add-hook 'LaTeX-mode-hook (lambda ()
  (define-key LaTeX-mode-map [f12] '(lambda () (interactive) (latex-save)))
  (define-key LaTeX-mode-map [(shift f12)] '(lambda () (interactive) (latex-view)))))


;; alias for better perl mode
(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist
      (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode)) auto-mode-alist ))
(setq interpreter-mode-alist (append interpreter-mode-alist
                                      '(("perl6" . cperl-mode))))


(define-minor-mode my-keys-minor-mode
  "A minor mode to override major mode keybindings"
  t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;;;default minor modes
(my-keys-minor-mode 1)

;;agenda views
(setq org-agenda-custom-commands
      '(("h" "Daily habits" 
         ((agenda ""))
         ((org-agenda-show-log t)
          (org-agenda-ndays 7)
          (org-agenda-log-mode-items '(state))
          (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":DAILY:"))))
        ("e" "Upcomming Exams" 
         ((agenda ""))
         ((org-agenda-show-log t)
          (org-agenda-ndays 7)
          (org-agenda-log-mode-items '(state))
          (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":EXAM:"))))))

;;orgmode journal
(defvar org-journal-date-format "%Y-%m-%d"  
  "Date format string for journal headings.")  
  
(defun org-journal-entry ()  
  "Create a new diary entry for today or append to an existing one."  
  (interactive)  
  (switch-to-buffer (find-file org-journal-file))  
  (widen)  
  (let ((today (format-time-string org-journal-date-format)))  
    (beginning-of-buffer)  
    (unless (org-goto-local-search-headings today nil t)  
      ((lambda ()   
         (org-insert-heading)  
         (insert today)  
         (insert "\n\n  \n"))))  
    (beginning-of-buffer)  
    (org-show-entry)  
    (org-narrow-to-subtree)  
    (end-of-buffer)  
    (backward-char 2)  
    (unless (= (current-column) 2)  
      (insert "\n\n  "))))  
        