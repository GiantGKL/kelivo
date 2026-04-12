import Log from '@ohos/flutter_ohos/src/main/ets/util/Log';
import {
  FlutterPlugin,
  FlutterPluginBinding,
} from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/FlutterPlugin';
import MethodChannel from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import { MethodCall } from '@ohos/flutter_ohos';
import {
  MethodCallHandler,
  MethodResult,
} from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';

const TAG = 'OhosFileSavePlugin';
const CHANNEL_NAME = 'app.file_save';

class OhosFileSaveMethodHandler implements MethodCallHandler {
  async onMethodCall(call: MethodCall, result: MethodResult): Promise<void> {
    try {
      switch (call.method) {
        case 'saveFileFromPath': {
          const args = call.args as Map<string, Object>;
          const sourcePath = String(args.get('sourcePath') ?? '');
          const rawFileName = String(args.get('fileName') ?? 'backup.zip');
          const fileName = rawFileName.trim().length > 0 ? rawFileName.trim() : 'backup.zip';

          if (sourcePath.length === 0) {
            result.error('FILE_SAVE_ERROR', 'sourcePath is empty', null);
            return;
          }

          const documentPicker = new picker.DocumentViewPicker();
          const options = new picker.DocumentSaveOptions();
          options.newFileNames = [fileName];
          options.fileSuffixChoices = ['ZIP|.zip'];

          let uris: Array<string>;
          try {
            uris = await documentPicker.save(options);
          } catch (err) {
            result.error('FILE_SAVE_ERROR', JSON.stringify({
              stage: 'picker_save',
              fileName,
              error: err,
            }), null);
            return;
          }
          if (!uris || uris.length === 0) {
            result.error('FILE_SAVE_ERROR', JSON.stringify({
              stage: 'picker_no_uri',
              fileName,
            }), null);
            return;
          }

          const targetUri = uris[0];
          Log.i(TAG, 'saveFileFromPath sourcePath=' + sourcePath + ', targetUri=' + targetUri);

          let sourceFile: fs.File;
          try {
            sourceFile = fs.openSync(sourcePath);
          } catch (err) {
            result.error('FILE_SAVE_ERROR', JSON.stringify({
              stage: 'open_source',
              sourcePath,
              targetUri,
              error: err,
            }), null);
            return;
          }

          let targetFile: fs.File | null = null;
          try {
            try {
              targetFile = fs.openSync(
                targetUri,
                fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE | fs.OpenMode.TRUNC,
              );
            } catch (err) {
              result.error('FILE_SAVE_ERROR', JSON.stringify({
                stage: 'open_target',
                sourcePath,
                targetUri,
                sourceFd: sourceFile.fd,
                error: err,
              }), null);
              return;
            }

            Log.i(TAG, 'saveFileFromPath sourceFd=' + sourceFile.fd + ', targetFd=' + targetFile.fd);
            try {
              fs.copyFileSync(sourceFile.fd, targetFile.fd);
            } catch (err) {
              result.error('FILE_SAVE_ERROR', JSON.stringify({
                stage: 'copy_fd_to_fd',
                sourcePath,
                targetUri,
                sourceFd: sourceFile.fd,
                targetFd: targetFile.fd,
                error: err,
              }), null);
              return;
            }
          } finally {
            fs.closeSync(sourceFile);
            if (targetFile != null) {
              fs.closeSync(targetFile);
            }
          }

          result.success(true);
          break;
        }
        default:
          result.notImplemented();
          break;
      }
    } catch (err) {
      Log.e(TAG, 'saveFileFromPath failed: ' + JSON.stringify(err));
      result.error('FILE_SAVE_ERROR', JSON.stringify(err), null);
    }
  }
}

export default class OhosFileSavePlugin implements FlutterPlugin {
  private methodChannel: MethodChannel | null = null;

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.methodChannel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
    this.methodChannel.setMethodCallHandler(new OhosFileSaveMethodHandler());
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    this.methodChannel?.setMethodCallHandler(null);
    this.methodChannel = null;
  }
}
