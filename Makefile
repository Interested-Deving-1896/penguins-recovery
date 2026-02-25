.PHONY: help bootloaders debian arch uki clean

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-16s %s\n", $$1, $$2}'

bootloaders: ## Package Debian bootloaders into bootloaders.tar.gz
	cd bootloaders && bash create-bootloaders

debian: ## Build Debian-based rescue ISO (requires root, debootstrap)
	cd builders/debian && sudo ./make

arch: ## Build Arch-based rescue ISO (requires mkarchiso)
	cd builders/arch && sudo mkarchiso -v -w /tmp/archiso-work -o out .

uki: ## Build UKI rescue EFI image (requires mkosi, systemd-ukify)
	cd builders/uki && mkosi build

clean: ## Remove build artifacts
	rm -rf bootloaders/bootloaders bootloaders/bootloaders.tar.gz
	rm -rf builders/debian/rootdir builders/debian/*.iso
	rm -rf builders/arch/work builders/arch/out
	rm -rf builders/uki/mkosi.builddir builders/uki/mkosi.cache
	rm -rf recovery-manager/target
