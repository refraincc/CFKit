//
//  UIDevice+Core.h
//  CFKit
//
//  Created by cc on 2020/4/26.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



static NSString *const CCDictionaryKey = @"com.cc.dictionaryKey";
static NSString *const CCUUIDKey = @"com.cc.uuidKey";

@interface UIDevice (Core)



+ (NSString *)cc_UUID;

+ (NSString *)cc_IDFA;

+ (NSString *)cc_appVersion;

+ (NSString *)cc_appBuild;

+ (NSString *)cc_appVersion_Build;

+ (NSString *)cc_appProjectName;

+ (NSString *)cc_iOSVersion;

+ (NSString *)cc_bundleID;




@end

NS_ASSUME_NONNULL_END
