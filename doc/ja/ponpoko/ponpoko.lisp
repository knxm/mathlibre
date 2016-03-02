(defvar $hbrowser "firefox")
(defvar $pbrowser "xpdf")
(defvar $hfile "index.html")
(defvar $pfile "MaximaBook.pdf")
(defvar $jhtmldir (if (string= *autoconf-win32* "true")("\\Maxima\Manual")
                      "/usr/local/Math-ja/PDF/"))
(defvar $jpdfdir  (if (string= *autoconf-win32* "true")("\\Manima\Manual")
                      "/usr/local/Math-ja/PDF/"))
(defmspec $ponpoko (x)
   (let
    ((topic ($sconcat (cadr x)))
     (exact-p (or (null (caddr x)) (eq (caddr x) '$exact)))
     (cl-info::*prompt-prefix* *prompt-prefix*)
     (cl-info::*prompt-suffix* *prompt-suffix*))
    (cond
         ((equal topic "html")
          ($system (concatenate 'string $hbrowser " " 
                    $jhtmldir $hfile "&")))
         ((equal topic "pdf")
          ($system (concatenate 'string $pbrowser " " 
                    $jpdfdir $pfile "&")))
         (t (if exact-p
             (cl-info::info-exact topic)
             (cl-info::info topic))))))
