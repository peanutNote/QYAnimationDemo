//
//  GradientProcessView.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "GradientProcessView.h"
#import "UIColor+Extensions.h"
#import "UIView+Extensions.h"

static const CGFloat kProcessHeight = 10.f;
static const CGFloat kTopSpaces = 5.f;
static const CGFloat kNumberMarkWidth = 60.f;
static const CGFloat kNumberMarkHeight = 20.f;
static const CGFloat kAnimationTime = 3.f;

@implementation GradientProcessView {
    CALayer *_maskLayer;
    UILabel *_numberMark;
    
    NSArray *_colorArray;
    NSArray *_colorLocationArray;
    CGFloat _numberPercent;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _colorArray = @[(id)[[UIColor colorWithHex:0xFF6347] CGColor],
                            (id)[[UIColor colorWithHex:0xFFEC8B] CGColor],
                            (id)[[UIColor colorWithHex:0x98FB98] CGColor],
                            (id)[[UIColor colorWithHex:0x00B2EE] CGColor],
                            (id)[[UIColor colorWithHex:0x9400D3] CGColor]];
        _colorLocationArray = @[@0.1, @0.3, @0.5, @0.7, @1];
        
        _numberMark = [[UILabel alloc] init];
        _numberMark.textColor = [UIColor colorWithHex:0xFF6347];
        _numberMark.font = [UIFont systemFontOfSize:13.f];
        _numberMark.enabled = NO;
        _numberMark.frame = CGRectMake(0, kTopSpaces, kNumberMarkWidth, kNumberMarkHeight);
        _numberMark.text = @"0.0";
        [self addSubview:_numberMark];
        // 文字背景
        CAGradientLayer *numberGradientLayer = [CAGradientLayer layer];
        numberGradientLayer.frame = CGRectMake(0, kTopSpaces, self.width, kNumberMarkHeight);
        [numberGradientLayer setColors:_colorArray];
        [numberGradientLayer setLocations:_colorLocationArray];
        [numberGradientLayer setStartPoint:CGPointMake(0, 0)];
        [numberGradientLayer setEndPoint:CGPointMake(1, 0)];
        [self.layer addSublayer:numberGradientLayer];
        [numberGradientLayer setMask:_numberMark.layer];
        _numberMark.frame = numberGradientLayer.bounds;
        
        // 进度条
        [self getGradientLayer];
        _numberPercent = 0;
    }
    return self;
}

- (void)setNUmberMarkLayer { // 提示文字设置渐变色
    CAGradientLayer *numberGradientLayer = [CAGradientLayer layer];
    numberGradientLayer.frame = CGRectMake(0, kTopSpaces, self.width, kNumberMarkHeight);
    [numberGradientLayer setColors:_colorArray];
    [numberGradientLayer setLocations:_colorLocationArray];
    [numberGradientLayer setStartPoint:CGPointMake(0, 0)];
    [numberGradientLayer setEndPoint:CGPointMake(1, 0)];
    [self.layer addSublayer:numberGradientLayer];
    [numberGradientLayer setMask:_numberMark.layer];
    _numberMark.frame = numberGradientLayer.bounds;
}

- (void)getGradientLayer { // 进度条设置渐变色
    // 灰色进度条背景
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = CGRectMake(0, self.height - kProcessHeight - kTopSpaces, self.width - 30, kProcessHeight);
    bgLayer.backgroundColor = [UIColor colorWithHex:0xF5F5F5].CGColor;
    bgLayer.masksToBounds = YES;
    bgLayer.cornerRadius = kProcessHeight / 2;
    [self.layer addSublayer:bgLayer];
    
    _maskLayer = [CALayer layer];
    _maskLayer.frame = CGRectMake(0, 0, (self.width - 30) * self.percent / 100.f, kProcessHeight);
    _maskLayer.borderWidth = self.height / 2;
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, self.height - kProcessHeight - kTopSpaces, (self.width - 30), kProcessHeight);
    gradientLayer.masksToBounds = YES;
    gradientLayer.cornerRadius = kProcessHeight / 2;
    [gradientLayer setColors:_colorArray];
    [gradientLayer setLocations:_colorLocationArray];
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    [gradientLayer setMask:_maskLayer];
    [self.layer addSublayer:gradientLayer];
}

- (void)setPercent:(CGFloat)percent {
    [self setPercent:percent animated:YES];
}

- (void)setPercent:(CGFloat)percent animated:(BOOL)animated {
    _percent = percent;
    [self circleAnimation];
    // 文字动画
    [UIView animateWithDuration:kAnimationTime animations:^{
        _numberMark.frame = CGRectMake((self.width - 30) * percent / 100, 0, kNumberMarkWidth, kNumberMarkHeight);
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeNumber:) userInfo:nil repeats:YES];
}

- (void)changeNumber:(NSTimer *)timer {
    if (_percent <= 0) {
        [timer invalidate];
    } else {
        _numberPercent += (self.percent / (kAnimationTime * 10.f));
        if (_numberPercent > self.percent) {
            [timer invalidate];
            _numberPercent = self.percent;
        }
        _numberMark.text = [NSString stringWithFormat:@"%.1f",_numberPercent];
    }
}

- (void)circleAnimation {
    // 进度条隐式事物动画
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setAnimationDuration:kAnimationTime];
    _maskLayer.frame = CGRectMake(0, 0, (self.width - 30) * _percent / 100.f, kProcessHeight);
    [CATransaction commit];
}

@end
