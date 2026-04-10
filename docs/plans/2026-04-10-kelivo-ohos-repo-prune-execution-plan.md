# Kelivo OpenHarmony Repo Prune Execution Plan

## Internal Grade Decision
L

Reason: this is a bounded repository cleanup with one implementation lane, straightforward verification, and no need for delegated multi-agent execution.

## Wave Structure
1. Freeze requirements and plan artifacts for the approved repository-level cleanup scope
2. Remove non-OHOS top-level platform directories and misleading CI/workflow surfaces
3. Keep or lightly adjust documentation to match the new repository focus
4. Rebuild OHOS `.hap`, inspect git state, commit, and push to `fork/master`

## Ownership Boundaries
- In scope: top-level platform folders, `.github/workflows/**`, `README.md`, governed docs/artifacts
- Out of scope: deep refactors in `lib/**`, local signing secrets, machine-global SDK setup

## Verification Commands
- `git status --short --branch`
- `flutter build hap --debug`
- `git status --short`

## Delivery Acceptance Plan
- First prove the repository surface is OHOS-focused by file removal
- Then prove the OHOS build still succeeds with a real `.hap`
- Then push the result to the configured fork remote on `master`

## Completion Language Rules
- Only say the cleanup is complete after file pruning, successful OHOS build verification, and successful push
- Describe remaining non-OHOS code inside `lib/` as intentionally retained historical logic, not fully removed support

## Rollback Rules
- Do not rewrite git history
- If a deletion breaks the OHOS build, restore only the minimum required files
- Do not modify unrelated dirty files except to avoid accidental commit inclusion

## Phase Cleanup Expectations
- Leave no temporary helper files outside governed docs/artifacts
- Keep governed requirement/plan docs as durable trace artifacts
- Ensure `.metadata` stays uncommitted unless intentionally required
