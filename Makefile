src := $(wildcard src/*.md)
target := $(addprefix build/, $(addsuffix .html, $(basename $(notdir $(src)))))
pflags := --from=markdown+east_asian_line_breaks+emoji
pflags += --to=html5
pflags += --standalone
pflags += --self-contained
pflags += --css=./style.css
pflags += -V header-includes='<script src="//twemoji.maxcdn.com/2/twemoji.min.js?2.5"></script>'
pflags += -V header-includes='<script>document.addEventListener("DOMContentLoaded", () => twemoji.parse(document.body, { folder: "svg", ext: ".svg" }));</script>'
cpflags = -V include-after='<a href="./index.html">一覧</a>'

build/%.html: src/%.md style.css
	@mkdir -p build
	pandoc $(pflags) $(cpflags) $< --output=$@

all: $(target) build/index.html

build/index.html: $(src) style.css
	@mkdir -p build
	./index.sh | pandoc $(pflags) --output=$@

.PHONY: clean
clean:
	rm -rf build/*

.PHONY: new
new:
	./new.sh

.PHONY: watch
watch: all
	firefox build/index.html
	while inotifywait -e close_write ./*; do make all -j 4; done
