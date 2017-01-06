//
//  PopAnimationDetailController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "PopAnimationDetailController.h"
#import <pop/pop.h>

@interface PopAnimationDetailController ()

@property (nonatomic, strong) UIView *square;

@end

@implementation PopAnimationDetailController {
    UIButton *_startBtn;
    UILabel *_label;
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
    if (_type == 3) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 40)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:32];
        _label.text = @"00:00:00";
        [self.view addSubview:_label];
    } else {
        if (!_square) {
            _square = [[UIView alloc] init];
            _square.frame = CGRectMake(20, 150, 60, 60);
            _square.backgroundColor = [UIColor redColor];
            [self.view addSubview:_square];
        }

    }
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBtn.frame = CGRectMake(0, 400, kScreenWidth, 45);
    [_startBtn setTitle:@"开始动画" forState:UIControlStateNormal];
    [_startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startBtn];
}

- (void)startAnimation:(UIButton *)sender {
    if (_type == 0) {
        [self popBasicAnimation];
    } else if (_type == 1) {
        [self popSpringAnimation];
    } else if (_type == 2) {
        [self popDecayAnimation];
    } else if (_type == 3) {
        [self popCustomAnimation];
    }
}

- (void)popBasicAnimation {
    POPBasicAnimation *anBasic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anBasic.toValue = @(self.square.center.x + 200);
    anBasic.beginTime = CACurrentMediaTime() + .5f;
    anBasic.duration = 0.4;
    anBasic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.square pop_addAnimation:anBasic forKey:@"position"];
}

- (void)popSpringAnimation {
    /*
     springBounciness:4.0    //[0-20] 弹力 越大则震动幅度越大
     springSpeed     :12.0   //[0-20] 速度 越大则动画结束越快
     dynamicsTension :0      //拉力  接下来这三个都跟物理力学模拟相关 数值调整起来也很费时 没事不建议使用哈
     dynamicsFriction:0      //摩擦 同上
     dynamicsMass    :0      //质量 同上
     */
    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anSpring.toValue = @(self.square.center.x + 200);
    anSpring.beginTime = CACurrentMediaTime() + .5f;
    anSpring.springBounciness = 10.0f;
    [self.square pop_addAnimation:anSpring forKey:@"position"];
}

- (void)popDecayAnimation {
    // 注意:这里对POPDecayAnimation设置toValue是没有意义的，会被忽略(因为目的状态是动态计算得到的)。POPDecayAnimation也是没有duration字段的，其动画持续时间由velocity与deceleration决定
    // deceleration:0.998  //衰减系数(越小则衰减得越快)
    POPDecayAnimation *anDecay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anDecay.velocity = @(600);
    anDecay.beginTime = CACurrentMediaTime() + .5f;
    [self.square pop_addAnimation:anDecay forKey:@"position"];
}

/*
 POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"prop" initializer:^(POPMutableAnimatableProperty *prop) {
 // read value
 prop.readBlock = ^(id obj, CGFloat values[]) {
 
 };
 // write value
 prop.writeBlock = ^(id obj, const CGFloat values[]) {
 
 };
 // dynamics threshold
 prop.threshold = 0.01;
 }];
 
 其组成就是一个readBlock一个writeBlock和一个threashold
 readBlock告诉POP当前的属性值
 writeBlock中修改变化后的属性值
 threashold决定了动画变化间隔的阈值 值越大writeBlock的调用次数越少
 
 POPAnimatableProperty其实是POP中一个比较重要的东西 像上面提到的POP自带的动画属性 查看源代码可以看到也只是POP自动帮你设置好了POPAnimatableProperty而已 其作用就是当动画的某个时间片被触发时 告诉系统如何根据当前时间片做出变化
 */

- (void)popCustomAnimation {
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *label = (UILabel*)obj;
            label.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)values[0] / 60, (int)values[0] % 60, (int)(values[0] * 100) % 100];
        };
//        prop.threshold = 0.01f;
    }];
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + .5f;    //延迟1秒开始
    [_label pop_addAnimation:anBasic forKey:@"countdown"];
}

@end
