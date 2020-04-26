//
//  UIColor+Core.h
//  CFKit
//
//  Created by cc on 2020/4/26.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Core)

/// 随机颜色
+ (instancetype)cc_randomColor;

/**
 16进制数色值转换成 UIColor对象
 
 @param hexValue 16进制数
 @param alphaValue 透明度
 @return UIColor
 */
+ (nonnull instancetype)cc_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (nonnull instancetype)cc_colorWithHex:(NSInteger)hexValue;

/**
 字符串16进制色值转换成 UIColor对象
 支持'#ffffff' or '#FFFFFF' or '0xFFFFFF'
 
 @param hexStr #ffffff' or '#FFFFFF' or '0xFFFFFF'
 @param alpha 透明度 0~1
 @return UIColor
 */
+ (UIColor * _Nonnull)cc_colorWithHexStr:(NSString * _Nonnull)hexStr alpha:(CGFloat)alpha;

+ (UIColor * _Nonnull)cc_colorWithHexStr:(NSString * _Nonnull)hexStr;


@end

NS_ASSUME_NONNULL_END
