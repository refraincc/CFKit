//
//  BDMarqueeView.h
//  HotListDemo
//
//  Created by cc on 2020/4/1.
//  Copyright © 2020 refraincc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 文字滚动方向
 
 - SALabelScrollLeft: 从右向左
 - SALabelScrollRight: 从左向右
 */
typedef NS_ENUM(NSInteger, BDMarqueeLabelDirection) {
    BDMarqueeLabelLeft,
    BDMarqueeLabelRight
};



@interface BDMarqueeLabelView : UIView



/** 文字 */
@property (nonatomic, copy, nullable) NSString *text;

/** 富文本 */
@property (nonatomic, copy, nullable) NSAttributedString *attributedText;

/** 文字颜色*/
@property (nonatomic, strong, nonnull) UIColor *textColor;

/** 文字font */
@property (nonatomic, strong, nonnull) UIFont *font;

/** 文字阴影颜色 */
@property (nonatomic, strong, nullable) UIColor *shandowColor;

/** 文字阴影偏移 */
@property (nonatomic, assign) CGSize shandowOffset;

/** 文字位置，只在文字不滚动时有效 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/** 滚动方向，默认 SAMarqueeLabelLeft */
@property (nonatomic, assign) BDMarqueeLabelDirection marqueeDirection;

/** 滚动速度，默认30 */
@property (nonatomic, assign) CGFloat scrollSpeed;

/** 滚动速度，默认30 */
@property (nonatomic, assign) CGFloat duration;

/** 是否可以滚动 */
@property (nonatomic, readonly, assign) BOOL isScroll;

- (void)startAnimation ;


- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
