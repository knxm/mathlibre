(setq load-path (cons "/usr/share/Singular/emacs" load-path))
(autoload 'singular "singular"
  "Start Singular using default values." t)
(autoload 'singular-other "singular"
  "Ask for arguments and start Singular." t)
