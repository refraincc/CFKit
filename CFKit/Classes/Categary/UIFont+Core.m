//
//  UIFont+Core.m
//  CFKit
//
//  Created by cc on 2020/4/26.
//

#import "UIFont+Core.h"

//#import <AppKit/AppKit.h>


@implementation UIFont (Core)



+ (instancetype)cc_mediumSystemFontOfSize:(CGFloat)size{
    return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}


+ (instancetype)cc_blodSystemFontOfSize:(CGFloat)size{
    return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
}



+ (instancetype)cc_regularSystemFontOfSize:(CGFloat)size{
    return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}


@end
