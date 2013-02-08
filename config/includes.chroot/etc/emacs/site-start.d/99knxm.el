;; font-lock mode for color text

(require 'font-lock)
(if (not (featurep 'xemacs))
      (global-font-lock-mode t)
      )

;; auto time stamp

(if (not (memq 'time-stamp write-file-hooks))
    (setq write-file-hooks
          (cons 'time-stamp write-file-hooks)))
(setq time-stamp-start "Time-stamp:[ \t]*<")
(setq time-stamp-end ">")

;; for shell mode

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

