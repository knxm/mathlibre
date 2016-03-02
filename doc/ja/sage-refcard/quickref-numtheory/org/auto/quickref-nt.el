(TeX-add-style-hook "quickref-nt"
 (lambda ()
    (TeX-add-symbols
     '("kr" 2)
     "ex"
     "hr"
     "ZZ")
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

