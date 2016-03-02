MAINFILE=quickref-calc

LATEX=platex
DVI2PDF=dvipdfmx

all: pdf

pdf: ${MAINFILE}.pdf
${MAINFILE}.pdf: ${MAINFILE}.dvi
	${DVI2PDF} -l -p a4 ${MAINFILE}.dvi

${MAINFILE}.dvi: ${MAINFILE}.tex
	${LATEX} ${MAINFILE}.tex

#ebb
#pdflatex \\nonstopmode \\input quickref.tex 


clean:
	rm ${MAINFILE}.log ${MAINFILE}.aux ${MAINFILE}.pdf ${MAINFILE}.dvi
view:
	xdvi -paper a4r ${MAINFILE} 
