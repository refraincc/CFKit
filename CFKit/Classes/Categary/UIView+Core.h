//
//  UIView+Core.h
//  CFKit
//
//  Created by cc on 2020/4/26.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Core)


@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;




- (BOOL)cc_containsPoint:(CGPoint )point;

- (BOOL)cc_containsPoint:(CGPoint )point inView:(UIView *)view;

//给视图添加高斯模糊
- (void)cc_addBlurEffect:(UIBlurEffectStyle)style;


/**
 *  将View的某个区域渲染成图片
 *  @param aRect 渲染的区域
 *  @return 图片
 */
- (UIImage *)cc_renderedImageInRect:(CGRect)aRect;


//将View渲染成图片
- (UIImage *)cc_renderedImage;


//将View渲染成图片并写入文件
- (BOOL)cc_renderedImageAndSaveToFileWithFilePath:(NSString *)aFilePath;

//扩大点击区域
- (void)cc_extendHitTestSizeByWidth:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
