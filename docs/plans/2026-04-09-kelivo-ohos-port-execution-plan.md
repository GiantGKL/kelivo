# Kelivo OpenHarmony Port Execution Plan

## Internal Grade Decision
XL

Reason: the task spans environment validation, historical branch comparison, platform compatibility analysis, project integration, and end-to-end package verification.

## Wave Structure
1. Validate Flutter OHOS toolchain with a minimal project and real `.hap` output
2. Inventory `kelivo` dependencies and identify OHOS blockers
3. Introduce OHOS project/build structure into `kelivo`
4. Gate, shim, or replace unsupported plugins and platform-specific code
5. Build `kelivo` `.hap`, fix failures, and document the flow

## Ownership Boundaries
- Environment validation stays machine-local and non-destructive
- Main implementation happens only in `E:/1projects/kelivo`
- `E:/1projects/kelivo-ohos` is reference-only unless specific files are intentionally copied/adapted

## Verification Commands
- `flutter --version`
- `flutter doctor -v`
- `flutter create --platforms ohos <sample>`
- `flutter build hap --debug`
- project-specific `flutter pub get`
- project-specific `flutter build hap --debug`

## Delivery Acceptance Plan
- First prove the OHOS toolchain with a sample app
- Then prove `kelivo` package generation with a real `.hap`
- Record resulting artifact paths in the final report

## Completion Language Rules
- Only say "done" for the port after `kelivo` emits a `.hap`
- If the sample app works but `kelivo` does not, report the environment as ready and the port as in progress

## Rollback Rules
- Avoid destructive cleanup of existing repo content
- If a compatibility change breaks non-OHOS platforms, isolate it behind platform checks or revert that local change before proceeding

## Phase Cleanup Expectations
- Remove temporary sample apps if they are not useful to keep
- Keep only durable docs and required source changes
- Report any machine-local environment changes separately from repository changes
