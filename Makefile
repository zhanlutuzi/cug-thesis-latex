.PHONY: all clean distclean view

MAIN = main

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex cugthesis.cls $(wildcard frontmatter/*.tex chapters/*.tex backmatter/*.tex bib/*.bib)
	latexmk -xelatex $(MAIN).tex

clean:
	latexmk -c

distclean:
	latexmk -C

view: $(MAIN).pdf
	open $(MAIN).pdf
