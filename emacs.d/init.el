;; augment path and use common lisp features
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setenv "PATH" (concat "/opt/local/bin:" (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/local/gnat/bin/"
                                    "/usr/local/bin"
                                    "/usr/texbin"
                                    "/opt/local/bin") exec-path))
(require 'cl)

;; setup load path
(push (expand-file-name "~/.emacs.d/matt") load-path)
(push (expand-file-name "~/.emacs.d/async") load-path)
(push (expand-file-name "~/.emacs.d/helm") load-path)

;; get our packages up and running
(load "package")
(package-initialize)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(defvar matt/packages '(auto-complete
			autopair
			go-mode
			htmlize
			org
			paredit
			color-theme
      projectile
      flx
      flx-ido)
  "Default packages")

(defun matt/packages-installed-p ()
  (loop for pkg in matt/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (matt/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg matt/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(require 'ido)
(require 'my-keys)
(require 'my-ido)
(require 'my-linum)
(require 'color-theme)
(require 'uniquify)
(require 'auto-complete)
(require 'python)
(require 'helm-config)
(require 'google-c-style)

(when window-system
  (scroll-bar-mode 0)
  (setq mac-command-modifier 'meta)
  (color-theme-solarized-dark))

;; tags
(setq tags-table-list
      '("~/.tags/tellapart"))

;; projectile
(projectile-global-mode)

;; autocomplete
(global-auto-complete-mode t)
(setq ac-dwim t)

;; Replaces default names of "foo.py<2>" with "foo.py/bar" for all duplicates.
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
;; Rename all buffers after killing a uniquified buffer. This way a uniquified
;; buffer can return to its normal name if possible.
(setq uniquify-after-kill-buffer-p t)
;; Don't mess with special buffers
(setq uniquify-ignore-buffers-re "^\\*")


;; Highlight matching parentheses.
(show-paren-mode t)

;; Show column-number in the mode line.
(column-number-mode 1)

;; Wrap lines at 80 characters.
(setq-default fill-column 70)


;; line numbers
(global-linum-mode t)
(setq linum-format "%d ")

;; shitty whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Highlight matching parentheses.
(show-paren-mode t)

;; c/c++ style
;(add-hook 'c-mode-common-hook 'google-set-c-style)
;(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))

(defconst my-cc-style
  '("gnu"
    (c-offsets-alist . ((innamespace . [0])))))
(c-add-style "my-cc-mode" my-cc-style)

;;; general settings
(setq-default c-default-style "linux"
              tab-width 2
              default-tab-width 2
              c-basic-offset 4
              indent-tabs-mode nil
              js-indent-level 2)

(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(global-set-key (kbd "M-x") 'helm-M-x)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

(setq ggtags-enable-navigation-keys nil)
(eval-after-load "ggtags-mode"
  '(progn
     (define-key ggtags-mode-keymap (kbd "M-n") nil)
     (define-key ggtags-mode-keymap (kbd "\M-.") nil)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(comint-input-ignoredups t)
 '(comint-input-ring-size 500)
 '(custom-safe-themes (quote ("e7b8656484a079b3651360c621be0cf2bb6d67a2b9cf33b454cfc4d55fb22e58" "9a290da044d7847abab3502b98e3849284e4ee93bc9ffff7bb0af0967f9226cc" "a5057d754b6482dd48e3fc099004026c75592794c322bc7368368aaaf332897c" "1d13b4ccd3b56e6264f5895b5c6c575eedbfb73a36aaeb05b91565ea211faa2f" "ebdf5574672e641900e6c16275d0594b7de5b95d8e1283f57f9144a4eebf7806" "dc758223066a28f3c6ef6c42c9136bf4c913ec6d3b710794252dc072a3b92b14" default)))
 '(doc-view-continuous t)
 '(fringe-mode 0 nil (fringe))
 '(tool-bar-mode nil)
 '(yas/prompt-functions (quote (yas/dropdown-prompt yas/ido-prompt))))
(put 'erase-buffer 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
