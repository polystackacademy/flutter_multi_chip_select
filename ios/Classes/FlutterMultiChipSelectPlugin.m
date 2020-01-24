#import "FlutterMultiChipSelectPlugin.h"
#if __has_include(<flutter_multi_chip_select/flutter_multi_chip_select-Swift.h>)
#import <flutter_multi_chip_select/flutter_multi_chip_select-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_multi_chip_select-Swift.h"
#endif

@implementation FlutterMultiChipSelectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMultiChipSelectPlugin registerWithRegistrar:registrar];
}
@end
