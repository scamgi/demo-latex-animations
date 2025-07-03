# Makefile for compiling a LaTeX document

# --- Variables ---
# Define the LaTeX compiler
LATEX_COMPILER = pdflatex

# Define the main source file
SRC_FILE = beamer.tex

# Define the output directory for generated files
OUTPUT_DIR = out

# Define the full path for the output PDF
# This assumes the output PDF will have the same base name as the source file.
PDF_FILE = $(OUTPUT_DIR)/$(patsubst %.tex,%.pdf,$(SRC_FILE))


# --- Rules ---

# The default goal, executed when you just run `make`
# This tells make that the 'all' rule's goal is to create the PDF file.
all: $(PDF_FILE)

# Rule to compile the .tex file into a .pdf
# The target is the PDF file.
# The prerequisite is the source .tex file.
# The `| $(OUTPUT_DIR)` part is an "order-only prerequisite". It ensures that
# the output directory is created *before* running the pdflatex command,
# but changes to the directory itself won't trigger a re-compilation.
$(PDF_FILE): $(SRC_FILE) | $(OUTPUT_DIR)
	$(LATEX_COMPILER) -output-directory=$(OUTPUT_DIR) $(SRC_FILE)

# Rule to create the output directory
# This rule has a target but no prerequisites.
# The `-p` flag ensures that `mkdir` doesn't throw an error if the directory already exists.
$(OUTPUT_DIR):
	@mkdir -p $(OUTPUT_DIR)

# --- Phony Targets ---
# Phony targets are targets that don't represent actual files.
# 'clean' is a common one for removing generated files.
# 'all' is also declared phony as a matter of good practice.
.PHONY: all clean

# Rule to clean up the project directory
# It removes the entire output directory, including the PDF, .log, .aux files, etc.
clean:
	@echo "Cleaning up generated files..."
	rm -rf $(OUTPUT_DIR)


