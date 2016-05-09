;;; swiper-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ivy-mode) "ivy" "ivy.el" (21826 45835 0 0))
;;; Generated autoloads from ivy.el

(defvar ivy-mode nil "\
Non-nil if Ivy mode is enabled.
See the command `ivy-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ivy-mode'.")

(custom-autoload 'ivy-mode "ivy" nil)

(autoload 'ivy-mode "ivy" "\
Toggle Ivy mode on or off.
With ARG, turn Ivy mode on if arg is positive, off otherwise.
Turning on Ivy mode will set `completing-read-function' to
`ivy-completing-read'.

\\{ivy-minibuffer-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (swiper) "swiper" "swiper.el" (21826 45835 0 0))
;;; Generated autoloads from swiper.el

(autoload 'swiper "swiper" "\
`isearch' with an overview.
When non-nil, INITIAL-INPUT is the initial search pattern.

\(fn &optional INITIAL-INPUT)" t nil)

;;;***

;;;### (autoloads nil nil ("colir.el" "swiper-pkg.el") (21826 45835
;;;;;;  291191 0))

;;;***

(provide 'swiper-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; swiper-autoloads.el ends here
