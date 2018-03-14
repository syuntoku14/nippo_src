src := $(wildcard src/*.md)
css := $(wildcard css/*.css)
img := $(wildcard img/*.png)
target := $(addprefix build/, $(addsuffix .html, $(basename $(notdir $(src)))))
csstarget := $(addprefix build/, $(notdir $(css)))
imgtarget := $(addprefix build/img/, $(notdir $(img)))

pflags := --from=markdown+east_asian_line_breaks+emoji
pflags += --to=html5
pflags += --standalone
pflags += --katex
# use --katex-css + katex cli instead (waiting on https://github.com/Khan/KaTeX/issues/1216)
pflags += -V header-includes='<style>$(shell cat ./css/normalize.css ./css/style.css)</style>'

cpflags = -V include-after='<a href="./index.html">一覧</a>'
cpflags += -V include-after='<script>document.addEventListener("DOMContentLoaded", () => twemoji.parse(document.body, { folder: "svg", ext: ".svg" }));</script>'
cpflags += -V include-after='<script src="//twemoji.maxcdn.com/2/twemoji.min.js?2.5"></script>'

build/%.css: css/%.css
	@echo "$< -> $@"
	@cp $< $@

build/img/%.png: img/%.png
	@mkdir -p build/img
	@echo "$< -> $@"
	@optipng $< -out $@

build/%.html: src/%.md
	@mkdir -p build
	@echo "$< -> $@"
	@pandoc $(pflags) $(cpflags) $< --output=$@

all: $(target) $(csstarget) $(imgtarget) build/index.html

build/index.html: $(src)
	@mkdir -p build
	@echo "./index.sh -> $@"
	@./index.sh | pandoc $(pflags) --output=$@

.PHONY: clean
clean:
	rm -rf build/*

.PHONY: new
new:
	./new.sh

.PHONY: watch
watch: all
	tmux split-window -h "serve --local --open ./build/"
	while inotifywait -e close_write ./*; do make all -j 4; done

.PHONY: deploy
deploy: all
	./deploy.sh

