//
//  BDMarqueeView.m
//  HotListDemo
//
//  Created by cc on 2020/4/1.
//  Copyright © 2020 refraincc. All rights reserved.
//

#import "BDMarqueeLabelView.h"
#import "Masonry.h"

#define kDefaultScrollSpeed 30

@interface BDMarqueeLabelView ()<CAAnimationDelegate>

@property (nonatomic, strong) UILabel *label;

@end


@implementation BDMarqueeLabelView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInit];
    }
    return self;
}


- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setupInit {
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(self);
    }];
    self.clipsToBounds = YES;
    [self observeApplicationNotifications];
    self.scrollSpeed = kDefaultScrollSpeed;
    self.marqueeDirection = BDMarqueeLabelLeft;
    self.duration = 0.0f;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self startAnimation];
    }
}


- (void)startAnimation {
    
    if (self.isScroll) {
        [self.label.layer removeAnimationForKey:@"animationViewPosition"];
        
//        CGPoint pointRightCenter = CGPointMake(self.bounds.size.width + self.label.bounds.size.width/2, self.bounds.size.height/ 2.f);
        CGPoint pointRightCenter = CGPointMake(self.label.bounds.size.width/2, self.bounds.size.height/ 2.f);
        CGPoint pointLeftCenter  = CGPointMake(-self.label.bounds.size.width/ 2, self.bounds.size.height / 2.f);
        CGPoint fromPoint        = self.marqueeDirection == BDMarqueeLabelLeft ? pointRightCenter : pointLeftCenter;
        CGPoint toPoint          = self.marqueeDirection == BDMarqueeLabelLeft ? pointLeftCenter  : pointRightCenter;
        
        self.label.center = fromPoint;
        UIBezierPath *movePath    = [UIBezierPath bezierPath];
        [movePath moveToPoint:fromPoint];
        [movePath addLineToPoint:toPoint];
        
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnimation.path                 = movePath.CGPath;
        moveAnimation.removedOnCompletion  = YES;
        moveAnimation.repeatCount = 99999;
        moveAnimation.duration             = (self.label.bounds.size.width + self.bounds.size.width) / self.scrollSpeed;
        
        if (self.duration > 0) {
            moveAnimation.duration = self.duration;
        }
        
        moveAnimation.delegate             = self;
        [self.label.layer addAnimation:moveAnimation forKey:@"animationViewPosition"];
    }
}

- (void)stopAnimation{
    
    [self.label.layer removeAllAnimations];
    
}


#pragma mark-
#pragma mark- Event Response
- (void)observeApplicationNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //程序进入前台继续滚动
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startAnimation)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startAnimation)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.label.bounds.size.width > self.bounds.size.width) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimation) object:nil];
        _isScroll = YES;
        [self startAnimation];
    }else {
        self.label.frame = self.bounds;
        _isScroll = NO;
    }
}

#pragma mark-
#pragma mark- Getters && Setters
- (void)setText:(NSString *)text {
    if (![_text isEqualToString:text]) {
        if (self.isScroll) {
            [self.label.layer removeAnimationForKey:@"animationViewPosition"];
        }
        _text = text;
        self.label.text = text;
    }
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
        self.label.font = font;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (![_attributedText.string isEqualToString:attributedText.string]) {
        _attributedText = attributedText;
        self.label.attributedText = attributedText;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if (_textColor != textColor) {
        _textColor = textColor;
        self.label.textColor = textColor;
    }
    
}

- (void)setShandowColor:(UIColor *)shandowColor {
    if (_shandowColor != shandowColor) {
        _shandowColor = shandowColor;
        self.label.shadowColor = shandowColor;
    }
}
- (void)setShandowOffset:(CGSize)shandowOffset {
    _shandowOffset = shandowOffset;
    self.label.shadowOffset = shandowOffset;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.label.textAlignment = textAlignment;
}

- (void)setMarqueeDirection:(BDMarqueeLabelDirection)marqueeDirection {
    _marqueeDirection = marqueeDirection;
    [self setNeedsLayout];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}

@end
