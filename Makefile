src := $(wildcard src/*.md)
target := $(addprefix build/, $(addsuffix .html, $(basename $(notdir $(src)))))
pflags := --from=markdown+east_asian_line_breaks
pflags += --to=html5
pflags += --standalone
pflags += --self-contained
pflags += --css=./style.css

build/%.html: src/%.md style.css
	@mkdir -p build
	pandoc $(pflags) $< --output=$@

all: $(target) build/index.html

build/index.html: $(src) style.css
	@mkdir -p build
	./index.sh | pandoc $(pflags) --output=$@

.PHONY: clean
clean:
	rm -rf build/*

.PHONY: watch
watch: all
	firefox build/index.html
	while inotifywait -e close_write ./*; do make all; done
