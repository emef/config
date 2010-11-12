(load-file "~/.emacs.d/cedet-1.0/common/cedet.el")
(load-file "~/.emacs.d/dark-blue-3.el")

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/ecb-2.40")
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-o") (lambda ()
                              (interactive)
                              (move-end-of-line 1)
                              (newline-and-indent)))
(global-set-key (kbd "C-d") (lambda ()
                              (interactive)
                              (move-beginning-of-line 1)
                              (kill-whole-line)))
(global-set-key [f1] 'save-buffer)
(global-set-key [f2] (lambda ()
                       (interactive)
                       (ecb-minor-mode)))
(global-set-key (kbd "C-z") (lambda ()
                              (interactive)
                              (split-window-horizontally)
                              (next-window)
                              (shell)))
(global-set-key [f4] 'find-file)
(global-set-key [f3] 'other-window)
(global-set-key [f5] 'ido-switch-buffer)
(global-set-key (kbd "M-h") 'backward-char)
(global-set-key (kbd "M-j") 'next-line)
(global-set-key (kbd "M-k") 'previous-line)
(global-set-key (kbd "M-l") 'forward-char)

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-dark-blue3)))

(require 'yasnippet-bundle)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require 'python-mode)

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

(require 'auto-complete)
(global-auto-complete-mode t)

(require 'ecb)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-name "left3")
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-select-edit-window-on-redraw t)
 '(ecb-source-path (quote ("~/school/" "~/ai/" "~/web/")))
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 30)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(same-window-buffer-names (quote ("*mail*" "*inferior-lisp*" "*ielm*" "*scheme*")))
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))))

(require 'ido)
(ido-mode t)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


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
          current-frame-configuration)
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