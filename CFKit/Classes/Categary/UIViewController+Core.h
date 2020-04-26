//
//  UIViewController+Core.h
//  CFKit
//
//  Created by cc on 2020/4/26.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Core)

//当前直接响应的控制器
+ (UIViewController *)cc_respondViewController;

//当前页面展示的控制器
+ (UIViewController *)cc_currentViewController;


+ (UIViewController *)findBestViewController:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
