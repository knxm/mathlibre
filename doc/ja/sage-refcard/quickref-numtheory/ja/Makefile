MAINFILE=quickref-nt
IMGFILES=mod12.eps zeta.eps ec.eps ecmodp.eps

LATEX=platex
DVI2PDF=dvipdfmx
PDF2EPS=pdftops -eps


all: pdf

pdf: ${MAINFILE}.pdf
${MAINFILE}.pdf: ${MAINFILE}.dvi
	${DVI2PDF} -l -p a4 ${MAINFILE}.dvi

${MAINFILE}.dvi: ${MAINFILE}.tex ${IMGFILES} quickrefcard.sty
	${LATEX} ${MAINFILE}.tex

#ebb
#pdflatex \\nonstopmode \\input quickref.tex 

.SUFFIXES: .pdf .eps
.pdf.eps:
	${PDF2EPS} $<

clean:
	rm ${MAINFILE}.log ${MAINFILE}.aux ${MAINFILE}.pdf ${MAINFILE}.dvi
view:
	xdvi -paper a4r ${MAINFILE} 
