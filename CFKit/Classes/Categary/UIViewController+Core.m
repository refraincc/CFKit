//
//  UIViewController+Core.m
//  CFKit
//
//  Created by cc on 2020/4/26.
//

#import "UIViewController+Core.h"

//#import <AppKit/AppKit.h>


@implementation UIViewController (Core)



//当前直接响应的控制器
+ (UIViewController *)cc_respondViewController
{
    UIViewController *currentVC;
    id app = [NSClassFromString(@"UIApplication") valueForKey:@"sharedApplication"];
    UIWindow *window = [app keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        for(UIWindow *tmpWin in [app windows]) {
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [window subviews][0];
    id nextResponder = [frontView nextResponder];
    
    currentVC = [self findRespondViewController:nextResponder];
    return currentVC;
}


+ (id)findRespondViewController:(id)nextResponder {
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else {
        return [self findRespondViewController:nextResponder];
    }
}


//当前页面展示的控制器
+ (UIViewController *)cc_currentViewController {
    id app = [NSClassFromString(@"UIApplication") valueForKey:@"sharedApplication"];
    UIViewController *viewController = [[[app delegate] window] rootViewController];
    return [self findBestViewController:viewController];
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc
{
   if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    }else if ([vc isKindOfClass:[UIAlertController class]]) {
        return [self p_handleAlertTopViewController:vc.presentingViewController] ;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

@end



