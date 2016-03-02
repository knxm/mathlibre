MAINFILE=quickref
EPSFILES=2d.eps
BBFILES=3d.bb  graph.bb  linalg.bb  nb.bb nb2.bb  polytope.bb



LATEX=latex
DVI2PDF=dvipdfmx
PDF2EPS=pdftops -eps
EBB=ebb

all: pdf

pdf: ${MAINFILE}.pdf
${MAINFILE}.pdf: ${MAINFILE}.dvi
	${DVI2PDF}  -l -p a4 ${MAINFILE}.dvi

${MAINFILE}.dvi: ${MAINFILE}.tex ${EPSFILES} ${BBFILES}
	${LATEX} ${MAINFILE}.tex


#pdflatex \\nonstopmode \\input quickref.tex 

.SUFFIXES: .pdf .eps
.pdf.eps:
	${PDF2EPS} $<

.SUFFIXES: .png .bb
.png.bb:
	${EBB} $<


clean:
	rm ${MAINFILE}.log ${MAINFILE}.aux ${BBFILES} ${MAINFILE}.pdf ${MAINFILE}.dvi
view:
	xdvi -paper a4r ${MAINFILE} 
