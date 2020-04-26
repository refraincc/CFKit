//
//  UIDevice+Core.m
//  CFKit
//
//  Created by cc on 2020/4/26.
//

#import "UIDevice+Core.h"
#import <AdSupport/ASIdentifierManager.h>
//#import <AppKit/AppKit.h>


@implementation UIDevice (Core)



#pragma mark - 软件相关
+ (NSString *)cc_UUID {
    static NSString *uuidStr;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uuidStr = [UIDevice readUUID];
    });
    return uuidStr;
}

+ (NSString *)cc_IDFA {
    static NSString *idID;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        idID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    });
    return idID;
}

+ (NSString *)cc_appVersion {
    static NSString *appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] copy];
    });
    return appVersion;
}

+ (NSString *)cc_appBuild {
    static NSString *appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    });
    return appVersion;
}

+ (NSString *)cc_appVersion_Build {
    static NSString *appVersion_Build;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion_Build = [[NSString stringWithFormat:@"%@.%@", [self cc_appVersion], [self cc_appBuild]] copy];
    });
    return appVersion_Build;
}

+ (NSString *)cc_appProjectName {
    static NSString *appProjectName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appProjectName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    });
    return appProjectName;
}

+ (NSString *)cc_iOSVersion {
    static NSString *systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[UIDevice currentDevice] systemVersion];
    });
    return systemVersion;
}

+ (NSString *)cc_bundleID {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)readUUID {
    
    NSMutableDictionary *dic = (NSMutableDictionary *)[self load:CCUUIDKey];
    NSString *uuid = [dic objectForKey:CCDictionaryKey];
    if (uuid == nil) {
        uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        //放到字典中
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        [tempDic setObject:uuid forKey:CCDictionaryKey];
        
        //存储到keychain
        NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              (id)kSecClassGenericPassword,(id)kSecClass,
                                              CCUUIDKey, (id)kSecAttrService,
                                              CCUUIDKey, (id)kSecAttrAccount,
                                              (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
                                              nil];
        SecItemDelete((CFDictionaryRef)keychainQuery);
        [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:tempDic] forKey:(id)kSecValueData];
        SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    }
    return uuid;
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          (id)kSecClassGenericPassword,(id)kSecClass,
                                          CCUUIDKey, (id)kSecAttrService,
                                          CCUUIDKey, (id)kSecAttrAccount,
                                          (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
                                          nil];
    
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            
        } @finally {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

@end
