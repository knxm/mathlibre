(TeX-add-style-hook "quickref-calc"
 (lambda ()
    (TeX-add-symbols
     "ex"
     "hr")
    (TeX-run-style-hooks
     "amsfonts"
     "amsmath"
     "multicol"
     "url"
     "color"
     "pdftex"
     "geometry"
     "landscape"
     "graphicx"
     "latex2e"
     "art10"
     "article")))

