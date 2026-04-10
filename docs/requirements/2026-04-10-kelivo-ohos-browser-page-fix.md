# Kelivo OHOS Browser Page Fix Requirements

## Goal
Fix OpenHarmony URL opening so web links such as the settings "使用文档" entry no longer trigger the `harmony_browser_page` toast/error and instead open through a valid OHOS in-app browser page.

## Deliverable
- A shared Dart URL-launch helper that provides the required OHOS browser page header for http/https links
- An OHOS page and route declaration matching the required `harmony_browser_page` value
- Existing affected link entry points updated to use the helper

## Constraints
- Keep the change focused on OHOS browser launch behavior
- Do not alter unrelated business logic
- Preserve non-OHOS URL launch behavior as closely as possible

## Acceptance Criteria
- Opening settings docs on OHOS no longer shows the `harmony_browser_page` error toast
- The OHOS project contains the referenced browser page and route declaration
- Shared affected link entry points use the same launch path instead of ad hoc per-page logic
- `flutter build hap --debug` succeeds after the change

## Non-Goals
- Rework all link-opening code in the whole app
- Replace existing desktop-only behavior where it is not needed for OHOS
