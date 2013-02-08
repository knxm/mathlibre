; $OpenXM: OpenXM/src/kxx/init-openxm.scm,v 1.20 2009/02/23 08:11:26 takayama Exp $

(define (alist-search alist)
  (let* ((lang (or (getenv "LANG") "C"))
         (ent (assoc (substring lang 0 (min (string-length lang) 2)) alist)))
    (if ent (cdr ent) (cdr (assoc "C" alist)))))

(define manual-asir2000 
  (alist-search
   '(("C"  . "doc/asir2000/html-en/man_toc.html") ("ja" . "doc/asir2000/html-ja/man_toc.html"))))

(define manual-asir-contrib
  (alist-search
   '(("C"  . "doc/asir-contrib/en/cman-html/cman-en_toc.html") ("ja" . "doc/asir-contrib/ja/cman-html/cman-ja_toc.html"))))

; (define (openxm-eval t)
;   (import-from (texmacs plugin plugin-cmd))
;   (import-from (texmacs plugin plugin-convert))
;   (plugin-eval "openxm" "default" (object->tree t)))

; (define (openxm-eval-paste t)
;   (insert-tree (object->tree (openxm-eval t))))

(define (openxm-path t)
  (if (string? t)
    (let* ((openxm-home (or (getenv "OpenXM_HOME") "/usr/local/OpenXM"))
           (local-path (string-append openxm-home "/" t))
           (web-prefix "http://www.math.kobe-u.ac.jp/OpenXM/Current/")
           (web-path   (string-append web-prefix t)))
      (if (url-exists? local-path) local-path web-path))))

(define w3m-cmd
  (cond 
   ((url-exists-in-path? "w3m")
    (cond ((url-exists-in-path? "rxvt")  "rxvt  -g 100x50 -e w3m")
          ((url-exists-in-path? "kterm") "kterm -g 100x50 -e w3m")
          ((url-exists-in-path? "xterm") "xterm -g 100x50 -e w3m")
          (else #f)))
   ((url-exists-in-path? "firefox" ) "firefox" )
   ((url-exists-in-path? "mozilla" ) "mozilla" )
   ((url-exists-in-path? "netscape") "netscape")
   ((url-exists-in-path? "iexplore") "iexplore")
   (else #f)))

(define (w3m t)
  (if (and (string? t) w3m-cmd)
    (system (string-append w3m-cmd " " t " &"))))

(define (w3m-search t)
  (w3m (openxm-path t)))

(define (openxm-initialize)
;   (menu-extend texmacs-session-help-icons
;     (if (in-openxm?)
;     |
;     ((balloon (icon "tm_help.xpm") "Risa/Asir manual")
;      (w3m-search manual-asir2000))))
  (menu-extend texmacs-extra-menu
    (if (in-openxm?)
      (=> "OpenXM"
;         (-> "Select engines"
;           ("Risa/Asir" (insert-string "!asir;"))
;           ("Kan/sm1"   (insert-string "!sm1;")))
;         (-> "Select display style"
;           ("LaTeX"     (openxm-eval "!latex;"))
;           ("verbatim"  (openxm-eval "!verbatim;")))
;         (-> "Load Modules (Asir)"
;           ("ccurve"    (openxm-eval "load(\"ccurve.rr\");"))
;           ("dsolv"     (openxm-eval "load(\"dsolv\");"))
;           ("ratint"    (openxm-eval "load(\"ratint\");"))
;           ("solv"      (openxm-eval "load(\"solv\");"))
;           ("sp"        (openxm-eval "load(\"sp\");"))
;           ("sturm"     (openxm-eval "load(\"sturm\");"))
;           ("sym"       (openxm-eval "load(\"sym\");"))
;           ("weight"    (openxm-eval "load(\"weight\");"))
;           ("yang"      (openxm-eval "load(\"yang.rr\");"))
;           )
;         (-> "Display Configuration (Asir)"
;           ("Load default"   (openxm-eval "noro_print_env(0);"))
;           ("Weyl algebra"   (openxm-eval "noro_print_env(\"weyl\");"))
;           ("Euler OPs"      (openxm-eval "noro_print_env(\"yang\");"))
;           )
;         ---
        (-> "Manuals"
          ("Risa/Asir manual"
           (w3m-search manual-asir2000))
          ("Asir-contrib manual"
           (w3m-search manual-asir-contrib)))
        (-> "Web"
          ("The OpenXM Project"  (w3m "http://www.math.kobe-u.ac.jp/OpenXM/"))
          ("Risa/Asir web page"  (w3m "http://www.math.kobe-u.ac.jp/Asir/index-ja.html")))
        )))
)

(define (openxm-serialize lan t)
  (import-from (utils plugins plugin-cmd))
  (with u (pre-serialize lan t)
    (with s (texmacs->verbatim (stree->tree u))
      (string-append (string-replace s "\n" "\v") "\n")
      )))

(plugin-configure openxm
  (:require (url-exists-in-path? "openxm"))
  (:initialize (openxm-initialize))
  (:serializer ,openxm-serialize)
  (:launch "exec openxm ox_texmacs")
  (:session "OpenXM[asir,sm1]"))
