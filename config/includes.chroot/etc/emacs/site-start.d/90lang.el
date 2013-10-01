;;
;; /etc/emacs/site-start.d/90lang.el
;;    mathlibre language settings (input methods etc.)
;;
(let ((lang (getenv "LANG")))
  (cond ((or (equal lang "ja_JP.UTF-8")
         (equal lang "ja_JP.EUC-JP"))
     (when (file-readable-p "/usr/share/emacs/site-lisp/emacs-mozc/mozc.el")
       (require 'mozc)
       (setq default-input-method "japanese-mozc")
	(setq mozc-candidate-style 'echo-area))
     (when (file-readable-p "/usr/share/emacs/site-lisp/yatex/yatex.el")
       (setq auto-mode-alist
         (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
         (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t))
     )
    (t nil)))
