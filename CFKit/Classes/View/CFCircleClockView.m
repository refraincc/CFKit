//
//  BDCircleView.m
//  TestDemo
//
//  Created by cc on 2021/1/26.
//

#import "CFCircleClockView.h"



@interface CFCircleWeakProxy : NSProxy

@property (nonatomic, weak)id target;

@end

@implementation CFCircleWeakProxy

+ (instancetype)proxyWithTarget:(id)target{
    CFCircleWeakProxy *proxy = [CFCircleWeakProxy alloc];
    proxy.target = target;
    return proxy;
}



//在第二步 这个方法返回一个对象，则这个对象会作为消息的新接收者
- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

//这是最后一次机会将消息转发给其它对象 用来防护 doesNotRecognizeSelector crash
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

//消息转发机制从这个方法中获取信息来创建NSInvocation对象 和 forwardInvocation 方法一起用
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end


@interface CFCircleClockView ()

@property (nonatomic, strong)CAShapeLayer *shapeLayer;

@property (nonatomic, strong)UIBezierPath *bezierPath;

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)NSDate *finishDate;

@property (nonatomic, strong)CABasicAnimation *pathAnima;


@end



@implementation CFCircleClockView

- (void)dealloc{
    NSLog(@"%s", __func__);
}


- (instancetype)init{
    if (self = [super init]) {
        [self p_initWithData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_initWithData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self p_initWithData];
    }
    return self;
}



- (void)p_initWithData{
    
    
    _duation = 60.0f;
    _interval = 0.3f;
    _lineWidth = 1.0f;
    
    self.backgroundColor = [UIColor clearColor];
    
    
    
}



- (void)startCountdown{
    
    
    self.finishDate = [NSDate dateWithTimeIntervalSinceNow:self.duation];

    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    

    self.timer = [NSTimer timerWithTimeInterval:self.interval target:[CFCircleWeakProxy proxyWithTarget:self] selector:@selector(updateWithTimer:) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.shapeLayer.strokeColor = self.strokeColor ? self.strokeColor.CGColor : self.shapeLayer.strokeColor;
    
    self.shapeLayer.lineWidth = self.lineWidth;
    
    [self updateWithTimer:self.timer];
    
    
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)updateWithTimer:(NSTimer *)timer{
    
    NSTimeInterval time = [self p_timeWithFinishDate:self.finishDate];
    
    if ([self.delegate respondsToSelector:@selector(circleClockView:didTimer:)]) {
        [self.delegate circleClockView:self didTimer:time];
    }
    
    
    if (time < -self.interval) {
//        [timer invalidate];
        [timer invalidate];
        timer = nil;
        
        if ([self.delegate respondsToSelector:@selector(circleClockViewDidFinish:)]) {
            [self.delegate circleClockViewDidFinish:self];
        }
        return;
    }
    
    CGFloat scale = time / self.duation;
    
    [self updateCircleLayerWith: 1 - scale];
    
}


- (void)updateCircleLayerWith:(CGFloat)scale{
    
    
    CGFloat radius = self.bounds.size.width / 2;
    
    if (!self.bezierPath) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        self.bezierPath = path;
    }
    
    
    CGPoint center = CGPointMake(radius, radius);
    
    [self.bezierPath removeAllPoints];
    
    
    CGFloat startAngle =  - M_PI_2;
    CGFloat endAngle = (M_PI * 2 * scale  - M_PI_2) * 0.9999;
    
    
    [self.bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle  clockwise:YES];
    
    
    self.shapeLayer.path = self.bezierPath.CGPath;
    
    [self.layer addSublayer:self.shapeLayer];
    
    
    NSInteger count = self.duation - [self p_timeWithFinishDate:self.finishDate] - 1;
    NSTimeInterval fromValue = count / (count + 1.0);
    
    
    
    self.pathAnima.duration = self.interval;
    self.pathAnima.fromValue = [NSNumber numberWithFloat:fromValue];
    self.pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    [self.shapeLayer addAnimation:self.pathAnima forKey:@"strokeEndAnimation"];
    
        
    
}



- (NSInteger)timeCountdown{
    
    return [self p_timeWithFinishDate:self.finishDate];
    
}



- (NSTimeInterval)p_timeWithFinishDate:(NSDate *)date{
    
    return [date timeIntervalSinceDate:[NSDate date]];
}


- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {

        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillRule = kCAFillRuleNonZero;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.opacity = 2;
        shapeLayer.lineWidth = 1.0f;
        shapeLayer.lineJoin = kCALineCapSquare;
        shapeLayer.shadowOffset = CGSizeZero;
        shapeLayer.shadowRadius = 0.0f;
        shapeLayer.shadowColor = [UIColor clearColor].CGColor;
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

- (CABasicAnimation *)pathAnima{
    if (!_pathAnima) {
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pathAnima.fillMode = kCAFillModeForwards;
        _pathAnima = pathAnima;
    }
    return _pathAnima;
}



@end
