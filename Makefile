# ── Makefile ── CV_Paulo build system ─────────────────────────────────────────
#
#  make -f ~/bin/Makefile SRC=mydoc.md        →  build mydoc.pdf + mydoc.html
#  CSS=my.css make                            →  override stylesheet
#  FONT_SIZE=9.5pt make                       →  custom font size
#  ORIENTATION=landscape make                 →  landscape
#  PREVIEW=yes make                           →  open PDF after build
#  make html / make all / make clean
#
# Requirements:
#   pandoc        (>= 2.x)
#   weasyprint    (pip install weasyprint)
# ──────────────────────────────────────────────────────────────────────────────

# Directory where this Makefile lives — used to locate layout.css when called with -f
MKDIR := $(dir $(lastword $(MAKEFILE_LIST)))

SRC         ?= src.md
CSS         ?= $(MKDIR)layout.css   # defaults to ~/bin/layout.css

# Derive output names from SRC basename: foo.md → foo.pdf / foo.html
BASENAME    := $(basename $(SRC))
OUT         := $(BASENAME).pdf
HTML        := $(BASENAME).html

FONT_SIZE   ?= 8.8pt
ORIENTATION ?= portrait
PREVIEW     ?= no

# portrait → "A4"  |  landscape → "A4 landscape"
CSS_SIZE = $(if $(filter landscape,$(ORIENTATION)),A4 landscape,A4)

# Injected into <head> — guaranteed to reach WeasyPrint regardless of CWD
STYLE_HDR := .cv-style-inject.html

PANDOC := pandoc
FLAGS  := --standalone \
          --metadata title="" \
          --css $(CSS) \
          --include-in-header $(STYLE_HDR) \
          --highlight-style=tango

# STYLE_HDR is phony so it is always regenerated — changes take effect immediately
.PHONY: all pdf html clean $(STYLE_HDR)

$(STYLE_HDR):
	printf '<style>html { font-size: %s !important; } @page { size: %s; }</style>\n' \
	  "$(FONT_SIZE)" "$(CSS_SIZE)" > $@

all: pdf html

pdf: $(SRC) $(CSS) $(STYLE_HDR)
	$(PANDOC) $(FLAGS) \
	  --pdf-engine=weasyprint \
	  -o $(OUT) \
	  $(SRC)
	@echo "✓  $(OUT) [src=$(SRC) css=$(CSS) font-size=$(FONT_SIZE) orientation=$(ORIENTATION)]"
	@$(if $(filter yes,$(PREVIEW)),open $(OUT),)

html: $(SRC) $(CSS) $(STYLE_HDR)
	$(PANDOC) $(FLAGS) \
	  -o $(HTML) \
	  $(SRC)
	@echo "✓  $(HTML) [src=$(SRC) css=$(CSS) font-size=$(FONT_SIZE) orientation=$(ORIENTATION)]"

clean:
	rm -f $(OUT) $(HTML) $(STYLE_HDR)
