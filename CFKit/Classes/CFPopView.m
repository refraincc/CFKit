//
//  CFPopView.m
//  PopView
//
//  Created by cc on 2018/6/4.
//  Copyright © 2018年 refraincc. All rights reserved.
//

#import "CFPopView.h"

#define TriangleHeight 10


@interface CFPopView ()

@property (nonatomic, strong)UILabel *label;

@property (nonatomic, strong)UIImageView *backgroundImageView;

@property (nonatomic, copy)NSDictionary *attributes;

@property (nonatomic, strong)CAShapeLayer *backgroundLayer;

@property (nonatomic, strong)CAShapeLayer *triangleLayer;

@end



@implementation CFPopView

#pragma mark - 构造函数

- (instancetype)init{
    if (self = [super init]) {
        
        [self setupSubViews];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setupSubViews];
        
    }
    return self;
}

- (void)initUI{
    
    //默认属性
    self.font = [UIFont systemFontOfSize:12];
    
    self.textColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor orangeColor];
    
    self.textEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.textAlignment = NSTextAlignmentCenter;
    
    self.offset = 0.5;
}


- (void)setupSubViews{
    
    
    
    [self addSubview:self.label];
    
    
    [self initUI];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    UIEdgeInsets textEdgeInsets = [self calculateTextEdgeInsetsWithTriangleStyle:self.triangleStyle];
    
    
    CGFloat labelX = textEdgeInsets.left;
    CGFloat labelY = textEdgeInsets.top;
    CGFloat labelW = self.bounds.size.width - textEdgeInsets.left - textEdgeInsets.right;
    CGFloat labelH = [self textSizeWithTriangleStyle:self.triangleStyle].height;
    
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}

- (void)layoutSelfFrame{
    
    
    CGSize selfSize = [self textSizeWithTriangleStyle:self.triangleStyle];
    
    UIEdgeInsets textEdgeInsets = [self calculateTextEdgeInsetsWithTriangleStyle:self.triangleStyle];
    
    CGFloat selfHeight = selfSize.height + textEdgeInsets.top + textEdgeInsets.bottom;
    
    CGFloat selfWidth = selfSize.width + textEdgeInsets.left + textEdgeInsets.right;
    
    CGPoint center = self.center;
    
    CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, selfWidth, selfHeight);
    
    
    if (self.triangleStyle == CFPopViewTriangleSytleTop || self.triangleStyle == CFPopViewTriangleSytleNone) {
        newFrame.size.height = selfHeight;
    }else if (self.triangleStyle == CFPopViewTriangleSytleBottom){
        
        newFrame.origin.y = newFrame.origin.y - (selfHeight - self.frame.size.height);
        newFrame.size.height = selfHeight;
        
    }else if (self.triangleStyle == CFPopViewTriangleSytleRight){
        newFrame.origin.x = newFrame.origin.x - (selfWidth - self.frame.size.width);
        newFrame.size.width = selfWidth;
        newFrame.size.height = selfHeight;
    }else if (self.triangleStyle == CFPopViewTriangleSytleLeft){
        newFrame.origin.x = newFrame.origin.x + (selfWidth - self.frame.size.width);
        newFrame.size.width = selfWidth;
        newFrame.size.height = selfHeight;
    }
    
    self.frame = newFrame;
    
    
    self.center = center;
    
}



- (CGSize)textSizeWithTriangleStyle:(CFPopViewTriangleSytle)style{
    
    
    
    if (!self.label.text.length || !self.label.attributedText.length) {
        return CGSizeZero;
    }
    
    CGFloat textMaxWidth = 0;
    CGFloat textMaxHeight = 0;
    CGSize selfSize = self.bounds.size;
    
    CGFloat maxHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
    
    switch (style) {
        case CFPopViewTriangleSytleNone:
            textMaxWidth = selfSize.width;
            textMaxHeight = maxHeight;
            break;
        case CFPopViewTriangleSytleTop:
            textMaxWidth = selfSize.width;
            textMaxHeight = maxHeight;
            break;
        case CFPopViewTriangleSytleBottom:
            textMaxWidth = selfSize.width;
            textMaxHeight = maxHeight;
            break;
        case CFPopViewTriangleSytleLeft:
            textMaxWidth = maxWidth;
            textMaxHeight = selfSize.height;
            break;
        case CFPopViewTriangleSytleRight:
            textMaxWidth = maxWidth;
            textMaxHeight = selfSize.height;
            break;
            
        default:
            break;
    }
    
    UIEdgeInsets textEdgeInsets = [self calculateTextEdgeInsetsWithTriangleStyle:style];
    
    textMaxHeight -= (textEdgeInsets.top + textEdgeInsets.bottom);
    textMaxWidth -= (textEdgeInsets.left + textEdgeInsets.right);
    
    
    
    if (self.label.text.length) {
        return [self.label.text boundingRectWithSize:CGSizeMake(textMaxWidth, textMaxHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size;
    }else if (self.label.attributedText.length){
        return [self.label.attributedText boundingRectWithSize:CGSizeMake(textMaxWidth, textMaxHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    }else{
        return CGSizeZero;
    }
    
}

#pragma mark public


- (void)setText:(NSString *)text{
    _text = text;
    
    self.label.text = text;
    
    [self layoutSelfFrame];
    
    [self layoutBackgroudLayer];
    
}


- (void)setAttributedText:(NSAttributedString *)attributedText{
    _attributedText = attributedText;
    
    self.label.attributedText = attributedText;
    
    [self layoutSelfFrame];
    
    [self layoutBackgroudLayer];
    
}

- (void)setTriangleStyle:(CFPopViewTriangleSytle)triangleStyle{
    _triangleStyle = triangleStyle;

    if (!self.text.length) return;
    
    [self layoutSelfFrame];
    
    [self layoutBackgroudLayer];

}



- (void)setFont:(UIFont *)font{
    _font = font;
    
    self.label.font = font;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    
    self.label.textColor = textColor;
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    
    self.label.textAlignment = textAlignment;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    
    self.backgroundLayer.fillColor = backgroundColor.CGColor;
    
    self.triangleLayer.fillColor = backgroundColor.CGColor;
    
}


#pragma mark private

- (UIEdgeInsets)calculateTextEdgeInsetsWithTriangleStyle:(CFPopViewTriangleSytle)triangleStyle{
    UIEdgeInsets insets = self.textEdgeInsets;
    CGFloat marigin = TriangleHeight;
    if (triangleStyle == CFPopViewTriangleSytleLeft) {
        insets.left += marigin;
    }else if (triangleStyle == CFPopViewTriangleSytleRight){
        insets.right += marigin;
    }else if (triangleStyle == CFPopViewTriangleSytleTop){
        insets.top += marigin;
    }else if (triangleStyle == CFPopViewTriangleSytleBottom){
        insets.bottom += marigin;
    }
    return insets;
}

- (void)layoutBackgroudLayer{
    
    
    CGRect backgroundFrame = self.bounds;
    
    if (self.triangleStyle == CFPopViewTriangleSytleTop) {
        backgroundFrame.size.height = self.frame.size.height - TriangleHeight;
        backgroundFrame.origin.y = TriangleHeight;
    }else if (self.triangleStyle == CFPopViewTriangleSytleBottom){
        backgroundFrame.size.height = self.frame.size.height - TriangleHeight;
        backgroundFrame.origin.y = 0;
    }else if (self.triangleStyle == CFPopViewTriangleSytleLeft){
        backgroundFrame.origin.x = TriangleHeight;
        backgroundFrame.size.width -= TriangleHeight;
    }else if (self.triangleStyle == CFPopViewTriangleSytleRight){
        backgroundFrame.origin.x = 0;
        backgroundFrame.size.width -= TriangleHeight;
    }
    
    
    
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRoundedRect:backgroundFrame cornerRadius:5.0f];
    
    
    
    
    self.backgroundLayer.strokeColor = self.backgroundColor.CGColor;
    self.backgroundLayer.path = backgroundPath.CGPath;
    self.backgroundLayer.fillColor = self.backgroundColor.CGColor;
    self.backgroundLayer.cornerRadius = 5.0f;
    [self.layer insertSublayer:self.backgroundLayer atIndex:0];
    
    
    if (self.triangleStyle == CFPopViewTriangleSytleNone) {
        
        [self.triangleLayer removeFromSuperlayer];
        
        return;
    }
    
    CGFloat offset = 0;
    
    if (self.triangleStyle == CFPopViewTriangleSytleTop || self.triangleStyle == CFPopViewTriangleSytleBottom) {
        
        offset = self.offset * (backgroundFrame.size.width - TriangleHeight);
        
    }else{
        offset = self.offset * (backgroundFrame.size.height - TriangleHeight);
    }
    
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (self.triangleStyle == CFPopViewTriangleSytleTop) {
        [path moveToPoint:CGPointMake(offset, TriangleHeight)];
        [path addLineToPoint:CGPointMake(offset+ TriangleHeight, TriangleHeight)];
        [path addLineToPoint:CGPointMake(offset+ TriangleHeight / 2, 0)];
        [path addLineToPoint:CGPointMake(offset, TriangleHeight)];
    }else if (self.triangleStyle == CFPopViewTriangleSytleRight){
        [path moveToPoint:CGPointMake(self.bounds.size.width - TriangleHeight, offset)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width - TriangleHeight, offset + TriangleHeight)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, offset + TriangleHeight / 2)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width - TriangleHeight, offset)];
    }else if (self.triangleStyle == CFPopViewTriangleSytleLeft){
        [path moveToPoint:CGPointMake(TriangleHeight, offset)];
        [path addLineToPoint:CGPointMake(TriangleHeight, offset + TriangleHeight)];
        [path addLineToPoint:CGPointMake(0, offset + TriangleHeight / 2)];
        [path addLineToPoint:CGPointMake(TriangleHeight, offset)];
    }else if (self.triangleStyle == CFPopViewTriangleSytleBottom){
        [path moveToPoint:CGPointMake(offset, backgroundFrame.size.height)];
        [path addLineToPoint:CGPointMake(TriangleHeight + offset, backgroundFrame.size.height)];
        [path addLineToPoint:CGPointMake(offset + TriangleHeight / 2, self.bounds.size.height)];
        [path addLineToPoint:CGPointMake(offset, backgroundFrame.size.height)];
    }
    
    self.triangleLayer.strokeColor = self.backgroundColor.CGColor;
    self.triangleLayer.path = path.CGPath;
    self.triangleLayer.fillColor = self.backgroundColor.CGColor; // 默认为blackColor
    
    [self.layer addSublayer:self.triangleLayer];
}


#pragma  mark lazy


- (CAShapeLayer *)triangleLayer{
    if (!_triangleLayer) {
        CAShapeLayer *triangleLayer = [CAShapeLayer layer];
        _triangleLayer = triangleLayer;
        
    }
    return _triangleLayer;
}


- (CAShapeLayer *)backgroundLayer{
    if (!_backgroundLayer) {
        CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer = backgroundLayer;
    }
    return _backgroundLayer;
}


- (CGFloat)offset{
    if (_offset < 0 || _offset > 1) {
        return 0.5;
    }
    return _offset;
}



- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.numberOfLines = 0;
    }
    return _label;
}

- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]init];
    }
    return _backgroundImageView;
}



@end
