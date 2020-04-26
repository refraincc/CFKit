//
//  CFDumbView.m
//  UIResponder
//
//  Created by cc on 2020/4/26.
//  Copyright © 2020 refraincc. All rights reserved.
//

#import "CFDumbView.h"

@implementation CFDumbView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == self) {
        return nil;
    }
    return view;
}


@end
