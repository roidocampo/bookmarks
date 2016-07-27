
DIRS = $(sort $(dir $(wildcard images/*/)))
DIRS := $(filter-out images/,${DIRS})
NAMES = $(notdir $(DIRS:/=))

SOURCE_PNGS = $(addsuffix .png,$(join ${DIRS},${NAMES}))
TARGET_PNGS = $(addsuffix _150x150.png,$(join ${DIRS},${NAMES}))
TARGET_CSSS = $(addsuffix .css,$(join ${DIRS},${NAMES}))

index.html: roimarks.source.html images/images.css
	./process_includes.sh images/images.css icon/icon.html \
	    < roimarks.source.html \
	    > index.html

images/images.css: ${TARGET_CSSS} images/gen_b64.py
	cat ${TARGET_CSSS} > '$@'

%_150x150.png: %.png
	convert '$<' -resize 150x150 '$@'

%.css: %_150x150.png
	python3 images/gen_b64.py '$<' '$@'

.INTERMEDIATE: ${TARGET_CSSS}

clean:
	rm images/images.css

debug:
	@echo DIRS
	@for c in ${DIRS}; do echo "   "$$c; done
	@echo NAMES
	@for c in ${NAMES}; do echo "   "$$c; done
	@echo SOURCE_PNGS
	@for c in ${SOURCE_PNGS}; do echo "   "$$c; done
	@echo TARGET_PNGS
	@for c in ${TARGET_PNGS}; do echo "   "$$c; done
	@echo TARGET_CSSS
	@for c in ${TARGET_CSSS}; do echo "   "$$c; done
