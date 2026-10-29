# Linux Recovery: Canonical Upstream and Penguins-Recovery Downstream Plan

**Status:** Proposal / migration plan. This document does not itself change repository ownership, GitHub fork metadata, default branches, or synchronization workflows.

## Objective

Create `Interested-Deving-1896/linux-recovery` as the canonical, distribution-agnostic Linux recovery project, using `Interested-Deving-1896/penguins-recovery` as the initial source and implementation reference.

After the new repository is created and validated, `penguins-recovery` should become a downstream product that consumes suitable shared improvements from Linux Recovery while retaining its own name, purpose, integrations, and Penguins-specific features.

The intended dependency direction is:

```text
Linux Recovery (canonical shared recovery platform)
  ├── Penguins-Recovery (Penguins-specific downstream)
  ├── Future distribution/product adapters
  └── Other recovery-media integrations
```

Linux Recovery must not depend on Penguins-Recovery for its core operation. Penguins-Recovery may depend on Linux Recovery's documented interfaces and shared components.

## Repository audit baseline

The current `penguins-recovery` repository is an established, substantial project rather than a blank template. Its current tree includes:

- A Makefile-driven build and packaging interface.
- Modular builders for Debian, Arch, UKI/verified UKI, lightweight UKI, Buildroot, GPT/MBR images, Alpine/Lifeboat, and other recovery media.
- Distribution/tool adapters, including Debian, Arch, Alpine, Fedora, Gentoo, and SUSE paths.
- Shared recovery scripts for disk discovery, chroot rescue, Btrfs/EROFS recovery, GRUB restoration, UEFI repair, and related operations.
- A QML graphical interface, recovery-manager components, integration modules, and tests.
- Existing integrations documented in `INTEGRATIONS.md`, including Secure Boot, filesystem recovery, SBOM/license checks, attestation, and optional AI-assisted diagnostics.
- A GPL-3.0 license file.
- GitHub Actions for CI, documentation, upstream bootloader synchronization, PR automation, and the existing OSP/OOC mirror chain.

This inventory is an initial structural audit, not a claim that every builder or recovery operation has been executed or validated. Before moving code, each component needs classification, dependency review, license/attribution review, and appropriate tests.

## Principles

1. **Preserve the source.** Do not rename, delete, or broadly restructure `penguins-recovery` as part of establishing Linux Recovery.
2. **Preserve provenance.** Retain commit history where practical and preserve copyright notices, attribution, license terms, and third-party notices. Do not assume every bundled dependency has the same license merely because the repository contains GPL-3.0.
3. **Separate generic core from product policy.** Common recovery discovery, diagnostics, planning, execution safeguards, reporting, schemas, and interfaces belong in Linux Recovery when they can be implemented without Penguins-specific assumptions.
4. **Use adapters for variation.** Distribution/package-manager, bootloader, initramfs, filesystem, encryption, hardware, image-builder, and desktop integrations should be explicit adapters or optional integrations.
5. **Keep media production separate from recovery operations.** Building an ISO/UKI/disk image is one workflow; using an independent rescue environment to diagnose or repair an installed OS is another. They can share contracts and tools without being conflated.
6. **Default to safety.** Prefer read-only discovery and diagnostics. Require explicit target confirmation and approval before writes or destructive operations. Verify backups and post-repair results, and never write secrets to logs.
7. **Keep downstream changes safe.** Do not automatically overwrite Penguins-specific behavior, documentation, human-owned README sections, mirror-managed files, or downstream-only patches.
8. **Review synchronization.** Propagate shared upstream changes through reviewable PRs, with conflict detection, compatibility tests, and a clear record of source revisions. No blind force-push or silent downstream overwrite.
9. **Keep the core independently buildable and testable.** Linux Recovery must have its own documented setup, test suite, release process, and CI. Optional integrations should fail clearly and safely when unavailable.

## Recommended migration phases

### Phase 0 — Audit and inventory

- Record the source default branch and starting commit.
- Inventory source directories, tests, workflows, build commands, generated assets, external tools, and integrations.
- Classify each component as: generic core candidate, distribution adapter, recovery-media builder, product-specific integration, documentation/automation, or legacy/unclear.
- Identify privileged and destructive commands; document preconditions, target selection, rollback, and failure behavior.
- Review licenses and attribution at file/dependency level.
- Establish a baseline for which builds and tests currently pass. Do not infer that a command works solely because it exists.

### Phase 1 — Create the canonical repository

- Create `Interested-Deving-1896/linux-recovery` as a separate repository.
- Preserve the source history where practical; retain attribution and GPL-3.0 obligations after license review.
- Initially import the audited implementation with minimal functional changes rather than attempting a large rewrite during the repository transfer.
- Add a clear project identity, contribution guide, security/reporting guidance, architecture overview, and migration notes.
- Establish CI and branch protection appropriate to the new repository before treating it as canonical.
- Do not change `penguins-recovery`'s default branch or mirror workflows during this phase.

### Phase 2 — Define the shared contracts

Establish stable interfaces for:

- Environment and installation discovery.
- Storage, partition, filesystem, encryption, and boot-mode inventory.
- Read-only diagnostics and structured assessment reports.
- Recovery-plan representation, risk classification, approval gates, and execution results.
- Distribution, package-manager, bootloader, initramfs, filesystem, and recovery-media adapters.
- Machine-readable manifests, compatibility metadata, and test fixtures.

Use fixtures or disposable test images for destructive-path tests. Never run recovery/repair commands against a real host or disk as part of ordinary CI.

### Phase 3 — Generalize incrementally

- Move or refactor only components that pass the generic-core criteria.
- Keep vendor/product assumptions in adapters and integrations.
- Add tests for missing tools, unsupported systems, ambiguous target selection, read-only mode, encrypted storage, interrupted operations, and failed verification.
- Keep existing Penguins-Recovery behavior working during the transition.
- Avoid a wholesale directory move until tests and interfaces establish which components are truly shared.

### Phase 4 — Establish downstream consumption

- Document which Linux Recovery revision each Penguins-Recovery release consumes.
- Use reviewed PRs or a controlled sync process to bring generic improvements downstream.
- Run downstream compatibility checks before proposing changes.
- Preserve Penguins-specific features and human-owned documentation; require review for conflicts or files with special ownership.
- Keep the existing OSP/OOC mirror chain and its access/write restrictions unchanged unless a separately reviewed migration plan explicitly addresses them.
- Do not reverse GitHub fork metadata or alter mirror configuration as a side effect of code synchronization. Treat repository metadata, git history, and development direction as separate concerns.

### Phase 5 — Release and ecosystem integration

- Publish Linux Recovery's support matrix and distinguish implemented, experimental, and planned capabilities.
- Integrate with `linux-distro-stage3` and `penguins-eggs-stage3` through documented artifact/manifest contracts where appropriate; do not make Linux Recovery depend on either builder.
- Treat `ultimate-linux-suite` as a potential higher-level orchestrator, not as a dependency of the recovery core.
- Evaluate `linux-distro-prefix` as an optional integration only after an interface and dependency audit.
- Add additional distributions only when their adapters have tests and support documentation.

## Proposed initial layout

This is a target direction, not a mandate to move all current paths immediately:

```text
core/
  discovery/
  diagnostics/
  planning/
  execution/
  reporting/
adapters/
  distributions/
  package-managers/
  filesystems/
  bootloaders/
  initramfs/
recovery/
  boot/
  filesystem/
  system/
  backup-restore/
media/
  iso/
  uki/
  disk-image/
interfaces/
  cli/
  api/
schemas/
tests/
docs/
integrations/
```

Existing working builders and UI components should be mapped into this model only when doing so improves separation and can be validated.

## Acceptance criteria for calling Linux Recovery canonical

- The repository exists at `Interested-Deving-1896/linux-recovery` and has a documented license, provenance, ownership, and support policy.
- The initial import preserves relevant history/attribution and passes the declared baseline checks.
- The core builds and tests independently of Penguins-Recovery and optional ecosystem repositories.
- Generic interfaces and adapter boundaries are documented and exercised by tests.
- Read-only discovery and plan-only assessment are available before enabling write operations.
- Risky actions require explicit, target-specific approval and produce auditable results.
- Penguins-Recovery remains intact and independently usable while downstream integration is developed.
- Downstream sync is reviewable, conflict-aware, tested, and incapable of silently overwriting protected/custom files.
- Existing mirror restrictions and human-owned README sections remain intact.
- No merge, production workflow dispatch, mirror write, or destructive recovery operation occurs without its separately required authorization.

## Current blocker / next action

The available GitHub integration can inspect repositories and make branches, commits, files, and PRs in existing repositories, but it does not expose a repository-creation operation. The `linux-recovery` repository lookup currently returns 404, so it has not been created yet.

Therefore, this plan can be prepared in a reviewable PR in `penguins-recovery`, but the new canonical repository itself must be created through GitHub's repository-creation UI or another authorized mechanism that supports repository creation. Once it exists, the next steps are to import the audited baseline, verify it, and then implement the downstream workflow in separate reviewed changes.

No default-branch changes, merges, workflow dispatches, mirror writes, or recovery operations are part of this proposal.


## Ecosystem integration boundaries and initial artifact contract

The following roles are proposed from the repository audit. They are architectural boundaries, not claims that cross-repository integrations already exist or have passed end-to-end tests.

| Project | Proposed responsibility | Must not become |
| --- | --- | --- |
| `linux-recovery` | Canonical recovery core: discovery, diagnostics, recovery plans, approval gates, adapters, and result reporting | A required dependency of image builders or a product-specific Penguins application |
| `penguins-recovery` | Penguins-specific recovery product and initial implementation/source reference during migration | The permanent owner of all generic recovery logic |
| `linux-distro-stage3` | Generic distribution/root-filesystem build stage and its build artifacts | A recovery engine or implicit source of recovery policy |
| `penguins-eggs-stage3` | Penguins Eggs-oriented live-media/ISO stage and its artifacts | A mandatory dependency of the generic recovery core |
| `linux-distro-prefix` | Optional prefix/configuration/metadata integration, after its current interface is audited | A runtime dependency until a stable contract and compatibility tests exist |
| `penguins-eggs` | Existing upstream/product tooling used by the Penguins workflow where explicitly required | A hidden dependency for generic recovery-core tests |
| `ultimate-linux-suite` | Optional top-level orchestration and composition across builders, prefixes, and recovery products | The owner of recovery internals or a dependency required to build/test each component |

### Minimal versioned artifact manifest

Before wiring projects together, define and test one versioned manifest schema. The following is a conceptual minimum; it should be committed as a schema only after its required/optional fields and compatibility rules have tests.

```json
{
  "schema_version": "1.0",
  "producer": {
    "repository": "owner/repository",
    "revision": "full-git-commit-sha"
  },
  "artifact": {
    "kind": "rootfs|live-iso|uki|disk-image|recovery-report",
    "name": "artifact-name",
    "version": "producer-version",
    "format": "format-name",
    "architecture": "x86_64",
    "distribution": "distribution-id",
    "checksum": {
      "algorithm": "sha256",
      "value": "hex-digest"
    }
  },
  "capabilities": [],
  "provenance": {
    "build_workflow": "workflow-file",
    "source_revisions": []
  }
}
```

The `kind` values above illustrate a closed vocabulary, not a final JSON Schema enum. The production schema must define valid values, architecture aliases, checksum syntax, version semantics, and unknown-field behavior. A consumer must reject unsupported schema versions, missing required provenance, malformed checksums, and artifacts whose declared identity conflicts with the downloaded artifact. Never treat a manifest alone as proof that an artifact is safe.

### Integration sequence

1. **Inventory only:** record actual artifacts, formats, producer revisions, licenses, and existing workflow outputs in each repository.
2. **Schema and fixtures:** add the manifest schema plus positive/negative fixtures and a validator in one agreed home; do not duplicate divergent copies across repositories.
3. **Producer adoption:** each builder emits a manifest alongside artifacts without changing the artifact's existing name/path or downstream publishing behavior.
4. **Consumer validation:** Linux Recovery and the suite orchestrator validate schema, checksum, architecture, and provenance before accepting artifacts.
5. **Compatibility matrix:** test supported producer/consumer version pairs and make unsupported combinations fail clearly before recovery or installation begins.
6. **Reviewed rollout:** introduce each integration through a separate PR in the relevant repository. Do not modify mirror destinations, publish downstream artifacts, or run privileged recovery actions as part of schema development.

### Security and failure semantics

- Artifact discovery and validation are read-only; fetching an artifact must not execute it.
- Build metadata is untrusted input. Validate repository identifiers, paths, architecture strings, checksums, and URLs before use; do not interpolate manifest values into shell commands.
- Missing, stale, malformed, or unverifiable metadata is a hard validation failure, not a warning that permits an unsafe fallback.
- Preserve the producer's source commit and build provenance through any repackaging step.
- Keep build failure distinct from recovery-operation failure. A successfully built ISO is not evidence that repair actions are safe or effective.
- Use fixture files and disposable test images for CI; never point integration tests at a real host disk or a production mirror.
