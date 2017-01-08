//
//  CATransactionAnimationController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CATransactionAnimationController.h"

@interface CATransactionAnimationController ()

@property (retain, nonatomic) IBOutlet UISwitch *swich;

@end

@implementation CATransactionAnimationController {
    CALayer *_layer;
    CGFloat _corner;
}

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _layer = [CALayer layer];
    [_layer setFrame:CGRectMake(100, 100, 120, 230)];
    
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.borderColor = [UIColor blackColor].CGColor;
    _layer.opacity = 1.0f;
    [self.view.layer addSublayer:_layer];
}

- (IBAction)btnCornerClick:(id)sender {
    [CATransaction setDisableActions:_swich.on];
    _corner +=10;
    _layer.cornerRadius = _corner;
    
}


- (IBAction)btnColorClick:(id)sender {
    //[CATransaction setDisableActions:_swich.on];
    [CATransaction begin];
    [CATransaction setValue:(_swich.on?(id)kCFBooleanTrue:(id)kCFBooleanFalse) forKey:kCATransactionDisableActions];
    [self setLayerBC];
    [CATransaction commit];
    
    
}

- (IBAction)btnpostionClick:(id)sender {
    [CATransaction setValue:[NSNumber numberWithFloat:10.0f]
                     forKey:kCATransactionAnimationDuration]; // 设定隐式事务处理时间
    [CATransaction setDisableActions:_swich.on]; // 是否禁用事务动画
    [self setLayerPosition];
}

- (IBAction)btnBoundClick:(id)sender {
    // 隐式事务
    [CATransaction setDisableActions:_swich.on];
    [self setLayerBound];
}

- (IBAction)btnOpacityClick:(id)sender {
    // 显示事务
    [CATransaction begin];
    [CATransaction setValue:(_swich.on?(id)kCFBooleanTrue:(id)kCFBooleanFalse) forKey:kCATransactionDisableActions];
    [self setLayerOpcity];
    [CATransaction commit];
    
}
// 事务嵌套
- (IBAction)btnMixClick:(id)sender {
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0f]
                     forKey:kCATransactionAnimationDuration]; // 设定隐式事务处理时间
    [self setLayerBound];
    [CATransaction setValue:[NSNumber numberWithFloat:4.0f]
                     forKey:kCATransactionAnimationDuration]; // 设定隐式事务处理时间
    [self setLayerBC];
    [CATransaction setValue:[NSNumber numberWithFloat:6.0f]
                     forKey:kCATransactionAnimationDuration]; // 设定隐式事务处理时间
    [self setLayerPosition];
    [CATransaction commit];
}

- (IBAction)btnUseLessClick:(id)sender {
    // 显式事务无法在控件中应用,事务直接在runloop中提交了,所以看不到动画
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:4.0f]
                     forKey:kCATransactionAnimationDuration]; // 设定隐式事务处理时间
    if (_swich.layer.position.x == 80) {
        _swich.layer.position = CGPointMake(40,300);
    } else {
        _swich.layer.position = CGPointMake(80, 80);
    }
    [CATransaction commit];
}

- (void)setLayerBC {
    CGColorRef redColor = [UIColor redColor].CGColor, blueColor = [UIColor blueColor].CGColor;
    _layer.backgroundColor = (_layer.backgroundColor == redColor) ? blueColor : redColor;
}

- (void)setLayerOpcity {
    _layer.opacity = (_layer.opacity == 1.0f) ? 0.5f : 1.0f;
}

- (void)setLayerBound {
    if (_layer.bounds.size.width == _layer.bounds.size.height) {
        _layer.bounds = CGRectMake(_layer.bounds.origin.x, _layer.bounds.origin.y, _layer.bounds.size.width + 100, _layer.bounds.size.height);
    } else {
        _layer.bounds = CGRectMake(_layer.bounds.origin.x, _layer.bounds.origin.y, _layer.bounds.size.width - 100, _layer.bounds.size.height);
    }
}

- (void)setLayerPosition {
    _layer.position = CGPointMake(_layer.position.x + 50, _layer.position.y);
}

@end
