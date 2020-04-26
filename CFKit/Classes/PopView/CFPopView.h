//
//  CFPopView.h
//  PopView
//
//  Created by cc on 2018/6/4.
//  Copyright © 2018年 refraincc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CFPopViewTriangleSytleNone      = 0,
    CFPopViewTriangleSytleLeft      = 1,
    CFPopViewTriangleSytleRight     = 2,
    CFPopViewTriangleSytleTop       = 3,
    CFPopViewTriangleSytleBottom    = 4,
} CFPopViewTriangleSytle;



@interface CFPopView : UIView


/**
 显示文本
 */
@property (nonatomic, copy)NSString *text;
/**
 显示富文本
 */
@property (nonatomic, copy)NSAttributedString *attributedText;
/**
 字体
 */
@property (nonatomic, strong)UIFont *font;
/**
 文本颜色
 */
@property (nonatomic, strong)UIColor *textColor;
/**
 背景色
 */
@property (nonatomic, strong)UIColor *backgroundColor;
/**
 文本偏移量
 */
@property (nonatomic, assign)UIEdgeInsets textEdgeInsets;
/**
 三角符号的方向
 */
@property (nonatomic, assign)CFPopViewTriangleSytle triangleStyle;
/**
 三角符号偏移比例  默认0.5
 */
@property (nonatomic, assign)CGFloat offset; //0 ~ 1.0
/**
 文本布局方式
 */
@property (nonatomic, assign)NSTextAlignment textAlignment;

@end



