SRC_DIR := src
OUT_DIR := out
SOURCES := $(wildcard $(SRC_DIR)/*.txt)
OUTPUTS := $(patsubst $(SRC_DIR)/%.txt,$(OUT_DIR)/%.txt,$(SOURCES))

.PHONY: all check build test clean ci count

all: ci

check:
	@echo "check: $(words $(SOURCES)) source file(s) in $(SRC_DIR)"

$(OUT_DIR)/%.txt: $(SRC_DIR)/%.txt
	@mkdir -p $(OUT_DIR)
	@echo "  BUILD $< -> $@"
	@cp $< $@

build: $(OUTPUTS)

test: build
	@test -f $(OUT_DIR)/greeting.txt
	@test -f $(OUT_DIR)/notes.txt
	@test -f $(OUT_DIR)/services.txt
	@echo "TEST PASSED"

clean:
	@rm -rf $(OUT_DIR)

ci: clean check build test

count: build  ## report source files and built words
	@ls -1 $(SRC_DIR)/*.txt | wc -l
	@wc -w $(OUTPUTS) | tail -1
# count: see section 5 of the README
# OUTPUTS is set by the wildcard above
# run 'make help' for all targets
