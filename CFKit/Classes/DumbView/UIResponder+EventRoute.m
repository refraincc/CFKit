//
//  UIResponder+EventRoute.m
//  UIResponder
//
//  Created by cc on 2020/4/26.
//  Copyright © 2020 refraincc. All rights reserved.
//

#import "UIResponder+EventRoute.h"

//#import <AppKit/AppKit.h>


@implementation UIResponder (EventRoute)



- (void)routeWithEventName:(NSString *__nullable)eventName info:(NSDictionary * __nullable)info{
    [[self nextResponder] routeWithEventName:eventName info:info];
}


@end
