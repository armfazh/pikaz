# pdflatex
# tikz
# exiftool


pngs= $(patsubst %.tex,%.png,$(wildcard *.tex))
pdfs= $(patsubst %.tex,%.pdf,$(wildcard *.tex))

.PRECIOUS: $(pdfs)

all: $(pngs)

%.pdf: %.tex
	@echo "Generating" $@
	@pdflatex $^ -o $@ > /dev/null

%.png: %.pdf
	@echo "Converting" $@
	@convert -units PixelsPerInch -density 500 $^ $@
	@exiftool -overwrite_original \
		-author="Armando Faz" \
		-description="Quantum gates, $*" \
		-date="`date +'%F %T'`"\
		-XMP-dc:Rights="This work is licensed under the Creative Commons Attribution 4.0 International License." \
		-xmp:usageterms="This work is licensed under the Creative Commons Attribution 4.0 International License." \
		-XMP-cc:license="http://creativecommons.org/licenses/by/4.0/"\
		-XMP-cc:AttributionName="Armando Faz" \
		-XMP-cc:AttributionURL="http://armfazh.github.io" \
		$@ > /dev/null 

clean:
	rm -f $(pdfs) $(pngs)

