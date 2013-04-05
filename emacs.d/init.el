;;;macbook specific settings
(when window-system
    (setq mac-command-modifier 'meta))

;;;augment path
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin:/usr/local/bin:/usr/local/go/bin"))
(setq exec-path (append exec-path '("/usr/local/gnat/bin/"
                                    "/usr/local/bin"
                                    "/usr/texbin"
                                    "/opt/local/bin") exec-path))

;; setup load path
(push (expand-file-name "~/.emacs.d") load-path)
(let ((default-directory "~/.emacs.d/elpa/"))
      (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/plugins/"))
      (normal-top-level-add-subdirs-to-load-path))

(require 'my-keys)
(require 'my-ido)
(require 'uniquify)
;(require 'paredit)
(require 'auto-complete)
(require 'ido)
(require 'python)
(require 'erlang)
(require 'org)
(require 'color-theme)

;; Helper function to reload this file on the fly.
(defun reload-dot-emacs ()
  (interactive)
  (load-file "~/.emacs.d/init.el")
  (message ".emacs.d/init.el reloaded"))

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
(scroll-bar-mode 0)

;; shitty whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Highlight matching parentheses.
(show-paren-mode t)

;; shell fixes
(defadvice comint-previous-matching-input
    (around suppress-history-item-messages activate)
  "Suppress the annoying 'History item : NNN' messages from shell history isearch.
If this isn't enough, try the same thing with
comint-replace-by-expanded-history-before-point."
  (let ((old-message (symbol-function 'message)))
    (unwind-protect
      (progn (fset 'message 'ignore) ad-do-it)
    (fset 'message old-message))))

(add-hook 'shell-mode-hook
          (lambda ()
            (setq tab-width 8)))


;; make advice stick
(load "comint.el.gz")

;;; general settings
(setq-default c-default-style "linux"
              tab-width 4
              default-tab-width 4
              c-basic-offset 4
              indent-tabs-mode nil)

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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
