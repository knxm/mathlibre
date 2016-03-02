MAINFILE=quickref-linalg

LATEX=latex
DVI2PDF=dvipdfmx

all: pdf

pdf: ${MAINFILE}.pdf
${MAINFILE}.pdf: ${MAINFILE}.dvi
	${DVI2PDF} -l -p a4 ${MAINFILE}.dvi

${MAINFILE}.dvi: ${MAINFILE}.tex *.sty
	${LATEX} ${MAINFILE}.tex

#ebb
#pdflatex \\nonstopmode \\input quickref.tex 


clean:
	rm ${MAINFILE}.log ${MAINFILE}.aux ${MAINFILE}.dvi ${MAINFILE}.pdf
view:
	xdvi -paper a4r ${MAINFILE} &