.PHONY: install help

WRAPPERS_DIR := wrappers
INSTALL_DIR  := $(HOME)/.local/bin

install:
	@for f in $(WRAPPERS_DIR)/*; do \
		if [ -f "$$f" ]; then \
			name=$$(basename "$$f"); \
			cp "$$f" $(INSTALL_DIR)/"$$name"; \
			chmod +x $(INSTALL_DIR)/"$$name"; \
			echo "Installed $$name"; \
		fi; \
	done

help:
	@echo "Targets:"
	@echo "  install  - Copy all wrappers to ~/.local/bin/"
	@echo "  help     - Show this message"
	@echo ""
	@echo "Usage:"
	@echo "  make install"
