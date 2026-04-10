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
import deviceInfo from '@ohos.deviceInfo';

const TAG = 'SystemInfoPlugin';
const CHANNEL_NAME = 'kelivo/system_info';

class SystemInfoMethodHandler implements MethodCallHandler {
  onMethodCall(call: MethodCall, result: MethodResult): void {
    try {
      switch (call.method) {
        case 'getSystemInfo': {
          const data: Map<string, ESObject> = new Map();
          data.set('distributionOSName', deviceInfo.distributionOSName);
          data.set('displayVersion', deviceInfo.displayVersion);
          data.set('majorVersion', deviceInfo.majorVersion);
          data.set('seniorVersion', deviceInfo.seniorVersion);
          data.set('featureVersion', deviceInfo.featureVersion);
          result.success(data);
          break;
        }
        default:
          result.notImplemented();
          break;
      }
    } catch (err) {
      Log.e(TAG, 'onMethodCall failed: ' + JSON.stringify(err));
      result.error('SYSTEM_INFO_ERROR', JSON.stringify(err), null);
    }
  }
}

export default class SystemInfoPlugin implements FlutterPlugin {
  private methodChannel: MethodChannel | null = null;

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.methodChannel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
    this.methodChannel.setMethodCallHandler(new SystemInfoMethodHandler());
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    this.methodChannel?.setMethodCallHandler(null);
    this.methodChannel = null;
  }
}
