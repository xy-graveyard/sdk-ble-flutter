#import "XyoBlePlugin.h"
#import <xyo_ble/xyo_ble-Swift.h>

@implementation XyoBlePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftXyoBlePlugin registerWithRegistrar:registrar];
}
@end
