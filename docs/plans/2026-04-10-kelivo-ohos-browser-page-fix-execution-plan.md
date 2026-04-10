# Kelivo OHOS Browser Page Fix Execution Plan

## Internal Grade Decision
L

## Steps
1. Inspect current OHOS `url_launcher` expectations and identify the required page header and route shape
2. Add a shared helper for launching browser URLs with OHOS-specific webview headers
3. Add the OHOS browser page and register it in `main_pages.json`
4. Update affected link entry points to use the helper
5. Verify by rebuilding the OHOS `.hap`

## Verification
- `E:/sdk/flutter_ohos_3358/bin/flutter.bat build hap --debug`
