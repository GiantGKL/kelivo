# Kelivo OpenHarmony Port Requirements

## Goal
Port the current `kelivo` Flutter app to OpenHarmony in the main repository and make it buildable into a `.hap` package.

## Deliverable
- OpenHarmony-capable Flutter project rooted at `E:/1projects/kelivo`
- A repeatable build flow that can produce a `.hap`
- Compatibility handling for unsupported or desktop-only/mobile-only features

## Constraints
- Use the current `kelivo` codebase as the source of truth
- Use `E:/1projects/kelivo-ohos` only as a reference for historical OHOS adaptation patterns
- Keep work on the same drive as the Flutter OHOS SDK because Windows OHOS Flutter requires same-disk layout
- Prefer compatibility shims and platform gating over invasive rewrites where possible
- Do not rely on Android-only or desktop-only behavior for OHOS builds

## Acceptance Criteria
- `flutter doctor -v` reports a working HarmonyOS toolchain on this machine
- A minimal Flutter OHOS validation project can be created and built into a `.hap`
- `kelivo` gains OHOS project/build support in the main repo
- `kelivo` can build a `.hap` in debug mode at minimum
- Unsupported features are either replaced, disabled safely, or guarded by platform checks so the OHOS build succeeds

## Product Acceptance Criteria
- Core app startup works on OHOS
- Main navigation and essential UI render without desktop-specific dependencies crashing startup
- Build instructions are clear enough for local reproduction

## Manual Spot Checks
- Run `flutter --version`
- Run `flutter doctor -v`
- Create and build a minimal OHOS Flutter app
- Build `kelivo` into a `.hap`

## Completion Language Policy
- Do not claim the port is complete until a real `.hap` has been produced from `kelivo`
- Do not claim compatibility for features that are only stubbed or disabled

## Delivery Truth Contract
- Report which commands were run
- Report exact artifact paths produced
- Report any remaining unsupported plugin or feature gaps explicitly

## Non-Goals
- Android toolchain repair
- Chrome/web setup
- Publishing to an app store
- Release signing unless needed later

## Autonomy Mode
Interactive governed execution with implementation decisions inferred from repo context unless a blocking platform incompatibility requires escalation.

## Inferred Assumptions
- The installed Flutter OHOS SDK at `E:/sdk/flutter_ohos` is the intended SDK for this migration
- Current machine-local OHOS SDK path `E:/DevEco Studio/sdk` remains stable for this work
- Producing an unsigned or debug `.hap` is acceptable for initial success criteria
