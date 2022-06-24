BUILDDIR ?= out

ADOC_DEPS = -r asciidoctor-bibtex
ADOC_OPTS = -a revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@3.9.2 \
	--destination-dir=$(BUILDDIR) --trace

default: slides.adoc $(BLKEXT) $(BUNDLEDIR)
	bundle exec asciidoctor-revealjs \
		$(ADOC_OPTS) \
		$(ADOC_DEPS) \
		$<
	mv $(BUILDDIR)/slides.html $(BUILDDIR)/index.html
	cp revealjs-plugins-conf.js $(BUILDDIR)/
	cp revealjs-plugins.js $(BUILDDIR)/
	cp -R plugins $(BUILDDIR)/
	cp *.css $(BUILDDIR)/
	cp -R fonts $(BUILDDIR)/
	cp -R images $(BUILDDIR)/
	#cp -R videos $(BUILDDIR)/

clean:
	rm -f slides.html

present: slides.adoc
	ruby -run -e httpd $(BUILDDIR) -p 5000 -b 127.0.0.1 &
	open "http://localhost:5000/slides.html"

.PHONY: present clean default
