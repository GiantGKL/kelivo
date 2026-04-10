# Kelivo OpenHarmony Repo Prune Requirements

## Goal
Reduce the migrated `kelivo` repository so it is clearly focused on the OpenHarmony port and no longer carries unnecessary top-level artifacts for other target platforms.

## Deliverable
- A GitHub-ready repository rooted at `E:/1projects/kelivo`
- Top-level platform directories unrelated to OpenHarmony removed
- CI/workflow and documentation trimmed so the repo presents itself as an OpenHarmony-focused fork
- Existing OHOS build path preserved

## Constraints
- Use the current migrated `kelivo` repo as the source of truth
- Keep the existing OpenHarmony buildability intact
- Follow the user's approved scope: repository-level OHOS focus only
- Do not attempt a full source-level purge of all non-OHOS code paths inside `lib/`
- Do not commit local signing secrets or machine-local environment state

## Acceptance Criteria
- `android/`, `ios/`, `linux/`, `macos/`, `web/`, and `windows/` are removed from the repo root
- Non-OHOS GitHub workflow files that are now misleading are removed or reduced appropriately
- `README.md` remains a short Chinese description of upstream, OHOS status, and AI-verification disclaimer
- `flutter build hap --debug` still succeeds after the cleanup
- The result can be committed and pushed to `fork/master`

## Product Acceptance Criteria
- A reader opening the repo can immediately understand it is an OpenHarmony-focused fork
- The repo no longer advertises extra platform packaging surfaces that are not intended to be maintained here
- The OpenHarmony artifact path remains reproducible

## Manual Spot Checks
- Inspect top-level directory list after cleanup
- Inspect `.github/workflows/` after cleanup
- Run `flutter build hap --debug`
- Confirm target push branch and remote state before pushing

## Completion Language Policy
- Do not claim the repo is OHOS-only at source level; only claim repository-level pruning
- Do not claim other platforms remain supported after this cleanup

## Delivery Truth Contract
- Report which directories and workflow files were removed
- Report the exact verification command run
- Report the exact push target used

## Non-Goals
- Full Dart-level removal of desktop/mobile/web branching
- Refactoring dependencies solely to eliminate non-OHOS references
- Reworking app architecture beyond what is needed for repository-level cleanup

## Autonomy Mode
Interactive governed execution with one approved scope decision from the user, then autonomous implementation and verification.

## Inferred Assumptions
- Existing OHOS build configuration in `ohos/` is the only platform packaging surface the user wants to keep
- Existing ahead-of-origin local commits are intended to remain part of the branch history
- Removing obsolete top-level platform folders and workflows is acceptable even if some Dart code still contains historical platform branches
