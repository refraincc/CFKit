//
//  CFCircleClockView.h
//  TestDemo
//
//  Created by cc on 2021/1/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@class CFCircleClockView;

@protocol CFCircleClockViewDelegate <NSObject>

@optional

/// 倒计时结束
- (void)circleClockViewDidFinish:(CFCircleClockView *)circleClockView;

/// 进度
- (void)circleClockView:(CFCircleClockView *)circleClockView didTimer:(NSTimeInterval)timer;

@end




@interface CFCircleClockView : UIView


@property (nonatomic, weak)id<CFCircleClockViewDelegate> delegate;


/// 倒计时持续时长
@property (nonatomic, assign)NSTimeInterval duation;

/// 每次刷新间隔时间
@property (nonatomic, assign)NSTimeInterval interval;

/// 圆的颜色 默认 whiteColor
@property (nonatomic, copy) UIColor *strokeColor;

/// 线的宽度  默认1.0f
@property (nonatomic, assign)CGFloat lineWidth;

/*
 开始倒计时
 倒计时一旦开始不受前后台切换影响。
 */
- (void)startCountdown;

/// 停止
- (void)stop;

/// 距离目标时间戳剩余多少时间
- (NSInteger)timeCountdown;


@end

NS_ASSUME_NONNULL_END
