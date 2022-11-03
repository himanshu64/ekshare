#import "EkSharePlugin.h"
#if __has_include(<ekshare/ekshare-Swift.h>)
#import <ekshare/ekshare-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ekshare-Swift.h"
#endif

@implementation EkSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEkSharePlugin registerWithRegistrar:registrar];
}
@end
