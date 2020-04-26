//
//  UIColor+Core.m
//  CFKit
//
//  Created by cc on 2020/4/26.
//

#import "UIColor+Core.h"

//#import <AppKit/AppKit.h>


@implementation UIColor (Core)

+ (instancetype)cc_randomColor{
    
    return [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    
}

/**
 16进制数色值转换成 UIColor对象
 
 @param hexValue 16进制数
 @param alphaValue 透明度
 @return UIColor
 */
+ (nonnull instancetype)cc_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (nonnull instancetype)cc_colorWithHex:(NSInteger)hexValue {
    return [UIColor cc_colorWithHex:hexValue alpha:1.0];
}



/**
 字符串16进制色值转换成 UIColor对象
 支持'#ffffff' or '#FFFFFF' or '0xFFFFFF'
 
 @param hexStr #ffffff' or '#FFFFFF' or '0xFFFFFF'
 @param alpha 透明度 0~1
 @return UIColor
 */
+ (UIColor * _Nonnull)cc_colorWithHexStr:(NSString * _Nonnull)hexStr alpha:(CGFloat)alpha {
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) {
        NSAssert(false, @"HexString is illegal");
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) {
        NSAssert(false, @"HexString is illegal");
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((CGFloat) r / 255.0f)
                           green:((CGFloat) g / 255.0f)
                            blue:((CGFloat) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor * _Nonnull)cc_colorWithHexStr:(NSString * _Nonnull)hexStr {
    return [self cc_colorWithHexStr:hexStr alpha:1.0];
}


@end
