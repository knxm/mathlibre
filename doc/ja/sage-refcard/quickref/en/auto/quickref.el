(TeX-add-style-hook "quickref"
 (lambda ()
    (TeX-add-symbols
     "hr")
    (TeX-run-style-hooks
     "amsfonts"
     "amsmath"
     "multicol"
     "url"
     "geometry"
     "landscape"
     "graphicx"
     "latex2e"
     "art10"
     "article")))

