//
//  UIResponder+EventRoute.h
//  UIResponder
//
//  Created by cc on 2020/4/26.
//  Copyright © 2020 refraincc. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (EventRoute)

- (void)routeWithEventName:(NSString *__nullable)eventName info:(NSDictionary * __nullable)info;
@end

NS_ASSUME_NONNULL_END
