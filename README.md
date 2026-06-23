[update-readmes]   Mode: rewrite — migrating to template structure...
# penguins-recovery

[![Built with Ona](https://ona.com/build-with-ona.svg)](https://app.ona.com/#https://github.com/Interested-Deving-1896/penguins-recovery)

<!-- AI:start:what-it-does -->
This project provides a unified toolkit for Linux system recovery, designed for system administrators and advanced users. It supports building modular recovery images for various distributions (e.g., Debian, Arch) and formats (e.g., UKI, dm-verity). The toolkit includes pluggable builders, integration with penguins-eggs, and tools for creating bootloaders and rescue ISOs. It addresses the need for customizable, cross-distro recovery solutions in diverse environments.
<!-- AI:end:what-it-does -->

## Architecture

<!-- AI:start:architecture -->
The project uses a modular architecture to build a unified Linux system recovery toolkit. It consists of standalone builders for different Linux distributions (Debian, Arch) and specialized recovery images (UKI, UKI-lite, verity-UKI). Each builder operates independently, allowing flexibility in creating recovery artifacts. Integration with penguins-eggs provides additional system recovery capabilities. The `Makefile` orchestrates these components, offering targets for building, packaging, and dependency checks.

Key directories:
- `adapters/`: Interfaces for integrating with external tools or systems.
- `bin/`: Executable scripts and utilities.
- `bootloaders/`: Scripts and resources for packaging or building bootloaders.
- `builders/`: Subdirectories for each builder (e.g., `debian`, `arch`, `uki`).
- `common/`: Shared scripts and configurations.
- `gui/`: QML-based graphical user interface components.
- `integration/`: Integration scripts for penguins-eggs and other tools.
- `recovery-manager/`: Core logic for managing recovery workflows.
- `scripts/`: Helper scripts for various tasks.
- `tests/`: Test cases and validation scripts.
- `tools/`: Additional utilities for development and debugging.

Directory structure:
```plaintext
.
├── adapters
├── bin
├── bootloaders
├── builders
│   ├── arch
│   ├── debian
│   ├── uki
│   ├── uki-lite
│   └── verity-uki
├── common
├── gui
├── integration
├── recovery-manager
├── scripts
├── tests
└── tools
```
<!-- AI:end:architecture -->

## Install

<!-- Add installation instructions here. This section is yours — the AI will not modify it. -->

```bash
git clone https://github.com/Interested-Deving-1896/penguins-recovery.git
cd penguins-recovery
```

## Usage

<!-- Add usage examples here. This section is yours — the AI will not modify it. -->

## Configuration

<!-- Document configuration options here. This section is yours — the AI will not modify it. -->

## CI

<!-- AI:start:ci -->
The repository uses GitHub Actions for continuous integration and automation. Below are the workflows and their functions:

- **bootloaders-upstream-sync.yaml**: Synchronizes bootloader sources from upstream repositories. No secrets required.
- **mirror-osp-to-ooc.yaml**: Mirrors the repository from the open-source platform (OSP) to an organizational open-source copy (OOC). Requires `OOC_REPO_TOKEN` secret for authentication.
- **trigger-artifact-mirror.yml**: Triggers artifact mirroring to external storage or repositories. Requires `ARTIFACT_STORAGE_KEY` and `ARTIFACT_STORAGE_SECRET` secrets for access.

All workflows are located in the `.github/workflows` directory. Ensure required secrets are configured in the repository settings for workflows to function correctly.
<!-- AI:end:ci -->

## Mirror chain

<!-- AI:start:mirror-chain -->
This repo is maintained in [`Interested-Deving-1896/penguins-recovery`](https://github.com/Interested-Deving-1896/penguins-recovery) and mirrored through:

```
Interested-Deving-1896/penguins-recovery  ──►  OpenOS-Project-OSP/penguins-recovery  ──►  OpenOS-Project-Ecosystem-OOC/penguins-recovery
```

Changes flow downstream automatically via the hourly mirror chain in
[`fork-sync-all`](https://github.com/Interested-Deving-1896/fork-sync-all).
Direct commits to OSP or OOC are detected and opened as PRs back to `Interested-Deving-1896`.
<!-- AI:end:mirror-chain -->

## Contributors

<!-- AI:start:contributors -->
[@Interested-Deving-1896](https://github.com/Interested-Deving-1896): 73 commits  
[@github-actions[bot]](https://github.com/github-actions[bot]): 8 commits  
[@ona-agent](https://github.com/ona-agent): 1 commit  

*Note: This repository may be a mirror. Please check the upstream source for additional details.*
<!-- AI:end:contributors -->

## Origins

<!-- AI:start:origins -->
_Original project — no upstream fork._
<!-- AI:end:origins -->

## Resources

<!-- AI:start:resources -->
_No additional resource files found._
<!-- AI:end:resources -->

## License

<!-- AI:start:license -->
<!-- License not detected — add a LICENSE file to this repo. -->
<!-- AI:end:license -->
