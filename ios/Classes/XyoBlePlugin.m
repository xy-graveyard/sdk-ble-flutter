#import "XyoBlePlugin.h"
#import <sdk_ble_flutter/sdk_ble_flutter-Swift.h>

@implementation XyoBlePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftXyoBlePlugin registerWithRegistrar:registrar];
}
@end
