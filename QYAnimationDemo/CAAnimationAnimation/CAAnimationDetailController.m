//
//  CAAnimationDetailController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CAAnimationDetailController.h"
#import "GradientProcessView.h"
#import "DisplayLinkAnimation.h"

@interface CAAnimationDetailController ()<CAAnimationDelegate>

@end

@implementation CAAnimationDetailController {
    CALayer *_animationLayer;
    UIBezierPath *_bezierPath;
    UIButton *_startBtn;
    GradientProcessView *_processView;
}

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self mmInitViews];
}

#pragma mark - initViews

- (void)mmInitViews {
    if (_type != 6) {
        if (_type < 5) {
            if (!_animationLayer) {
                _animationLayer = [CALayer layer];
                _animationLayer.frame = CGRectMake(0, 0, 64, 64);
                _animationLayer.position = CGPointMake(32, 150);
                _animationLayer.backgroundColor = [UIColor greenColor].CGColor;
                [self.view.layer addSublayer:_animationLayer];
            }
            if (_type == 2) {
                _bezierPath = [[UIBezierPath alloc] init];
                [_bezierPath moveToPoint:CGPointMake(32, 150)];
                [_bezierPath addCurveToPoint:CGPointMake(332, 150)
                               controlPoint1:CGPointMake(108, 0)
                               controlPoint2:CGPointMake(257, 300)];
                
                CAShapeLayer *pathLayer = [CAShapeLayer layer];
                pathLayer.path = _bezierPath.CGPath;
                pathLayer.fillColor = [UIColor clearColor].CGColor;
                pathLayer.strokeColor = [UIColor redColor].CGColor;
                pathLayer.lineWidth = 3.0f;
                [self.view.layer addSublayer:pathLayer];
            }
        } else if (_type == 5) {
            _processView = [[GradientProcessView alloc] initWithFrame:CGRectMake(20, 150, kScreenWidth - 20, 45)];
            _processView.percent = 0;
            [self.view addSubview:_processView];
        }
        
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame = CGRectMake(0, 400, kScreenWidth, 45);
        [_startBtn setTitle:@"开始动画" forState:UIControlStateNormal];
        [_startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_startBtn];
    } else {
        DisplayLinkAnimation *cuteView = [[DisplayLinkAnimation alloc] initWithFrame:CGRectMake(0, 64, 320, 568)];
        cuteView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:cuteView];
    }
}

- (void)startAnimation:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    if (_type == 0) {
        [self basicAnimation];
    } else if (_type == 1) {
        [self keyframeAnimation];
    } else if (_type == 2) {
        [self groupAnimation];
    } else if(_type == 3) {
        [self springAnimation];
    } else {
        _processView.percent = 100.f;
    }
}

- (void)basicAnimation {
    CABasicAnimation *basicAnimatin=[CABasicAnimation animationWithKeyPath:@"position"];
    
    //设置开始值
    [basicAnimatin setFromValue:[NSValue valueWithCGPoint:_animationLayer.position]];
    //设置结束值
    [basicAnimatin setToValue:[NSValue valueWithCGPoint:CGPointMake(300, 150)]];
    //设置动画完成后是否动画返回开始值得位置（此属性默认为NO。）
    basicAnimatin.autoreverses= YES;
    //设置动画为累加效果（此属性默认为NO。）
    basicAnimatin.cumulative= YES;
    //设置动画完成后不返回为原位置。（此属性默认为YES。）
    basicAnimatin.removedOnCompletion=NO;
    basicAnimatin.fillMode=kCAFillModeForwards;
    //设置动画完成的时间
    [basicAnimatin setDuration:5.0];
    //_animationLayer.position=CGPointMake(100, 11);（此属性我认为是layer的中心点）
    //给layer添加动画第二个参数是该动画的一个标志（自己随意设置例如“aaaa”）
    [_animationLayer addAnimation:basicAnimatin forKey:@"aaaa"];
}

/*
 fillMode:作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用
 kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
 kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
 kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
 kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
 */
- (void)keyframeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    animation.values = @[value1,value2,value3,value4,value5];
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 4.0f;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //设置的是每个阶段速度变化的函数
    animation.timingFunctions=@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],];
    animation.delegate = self;
    
    [_animationLayer addAnimation:animation forKey:nil];
}

- (void)springAnimation {
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"position.x"];
    // 设置阻尼系数（此值越大弹框效果越不明显）
    springAnimation.damping = 5;
    // 设置刚度系数（此值越大弹框效果越明显）
    springAnimation.stiffness = 100;
    // 设置质量大小（越大惯性越大）
    springAnimation.mass = 1;
    // 设置初始速度
    springAnimation.initialVelocity = 0;
    [springAnimation setFromValue:[NSNumber numberWithFloat:_animationLayer.position.x]];
    // 设置结束值
    [springAnimation setToValue:[NSNumber numberWithFloat:100]];
    // 设置动画完成后是否动画返回开始值得位置
    springAnimation.autoreverses = NO;
    // 设置动画为累加效果（此属性默认为NO。）
    springAnimation.cumulative= YES;
    // 设置动画完成后不返回为原位置。（此属性默认为YES。）
    springAnimation.removedOnCompletion = NO;
    [springAnimation setDuration:springAnimation.settlingDuration];
    springAnimation.delegate = self;
    [_animationLayer addAnimation:springAnimation forKey:@"sadasd"];
}

- (void)groupAnimation {
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = _bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1, animation2];
    group.duration = 4.0f;
    group.delegate = self;
    
    [_animationLayer addAnimation:group forKey:@"group_animation"];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _startBtn.userInteractionEnabled = YES;
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"group_animation"]) {
        NSLog(@"组合动画执行完成");
    }
}

@end
