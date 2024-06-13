//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<restart_app/RestartAppPlugin.h>)
#import <restart_app/RestartAppPlugin.h>
#else
@import restart_app;
#endif

#if __has_include(<wifi_iot/WifiIotPlugin.h>)
#import <wifi_iot/WifiIotPlugin.h>
#else
@import wifi_iot;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [RestartAppPlugin registerWithRegistrar:[registry registrarForPlugin:@"RestartAppPlugin"]];
  [WifiIotPlugin registerWithRegistrar:[registry registrarForPlugin:@"WifiIotPlugin"]];
}

@end
