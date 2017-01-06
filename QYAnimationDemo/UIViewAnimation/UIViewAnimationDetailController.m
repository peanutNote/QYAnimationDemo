//
//  UIViewAnimationDetailController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "UIViewAnimationDetailController.h"

@interface UIViewAnimationDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *anView;
@end

@implementation UIViewAnimationDetailController

#pragma mark - ViewController Method

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_type == 5) {
        self.anView.image = nil;
        self.anView.backgroundColor = [UIColor lightGrayColor];
    } else if (_type == 9) {
        self.anView.image = [UIImage imageNamed:@"animationIcon_1"];
    }
}

- (void)changeFrame {
    CGRect originalRect = self.anView.frame;
    CGRect rect = CGRectMake(self.anView.frame.origin.x-20, self.anView.frame.origin.y-120, 160, 80);
    [UIView animateWithDuration:1 animations:^{
        self.anView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.anView.frame = originalRect;
        }];
    }];
}

- (void)changeBounds {
    CGRect originalBounds = self.anView.bounds;
    //尽管这个rect的x，y跟原始的不同，动画也只是改变了宽高
    CGRect rect = CGRectMake(0, 0, 300, 120);
    [UIView animateWithDuration:1 animations:^{
        self.anView.bounds = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.anView.bounds = originalBounds;
        }];
    }];
}

- (void)changeCenter {
    CGPoint originalPoint = self.anView.center;
    CGPoint point = CGPointMake(self.anView.center.x, self.anView.center.y-170);
    [UIView animateWithDuration:0.3 animations:^{
        self.anView.center = point;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.anView.center = originalPoint;
        }];
        
    }]; 
}

- (void)transform {
    CGAffineTransform originalTransform = self.anView.transform;
    [UIView animateWithDuration:2 animations:^{
        // self.anView.transform = CGAffineTransformMakeScale(0.6, 0.6);//缩放
        // self.anView.transform = CGAffineTransformMakeTranslation(60, -60);
        // self.anView.transform = CGAffineTransformIdentity;
        self.anView.transform = CGAffineTransformMakeRotation(4.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.anView.transform = originalTransform;
            
        }];
    }];
}

- (void)alpha {
    [UIView animateWithDuration:1 animations:^{
        self.anView.alpha = 0.2;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.anView.alpha = 1;
        }];
    }];
}

/*
 UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
 UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
 UIViewAnimationOptionRepeat                   //无限重复执行动画
 UIViewAnimationOptionAutoreverse              //执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置
 
 UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
 UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
 UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
 UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀
 
 StartTime：相对于Duration的开始时间   time = duration * startTime
 relativeDuration：相对于Duration的执行时间   time = duration * relativeDuration
 
 */
- (void)changeBackground{
    [UIView animateKeyframesWithDuration:10.0 delay:0.f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.f relativeDuration:1.0 / 5 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:1.0 / 5 relativeDuration:1.0 / 5 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:2.0 / 5 relativeDuration:1.0 / 5 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0 / 5 relativeDuration:1.0 / 5 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:4.0 / 5 relativeDuration:1.0 / 5 animations:^{
            self.anView.backgroundColor = [UIColor whiteColor];
        }];
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}

/*
 usingSpringWithDamping：范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显。下图演示了在initialSpringVelocity为0.0f的情况下，usingSpringWithDamping分别取0.2f，0.5f和1.0f的情况
 initialSpringVelocity：表示初始的速度，数值越大一开始移动越快。下图演示了在usingSpringWithDamping为1.0f时，initialSpringVelocity分别取5.0f，15.0f和25.0f的情况。值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
 */
- (void)springAnimation {
    CGRect originalRect = self.anView.frame;
    CGRect rect = CGRectMake(self.anView.frame.origin.x - 80, self.anView.frame.origin.y, 120, 120);
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
        self.anView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:1 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
           self.anView.frame = originalRect;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}

/*
 UIViewAnimationOptionLayoutSubviews            //进行动画时布局子控件
 UIViewAnimationOptionAllowUserInteraction      //进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
 UIViewAnimationOptionRepeat                    //无限重复执行动画
 UIViewAnimationOptionAutoreverse               //执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedCurve    //忽略嵌套动画的曲线设置
 UIViewAnimationOptionAllowAnimatedContent      //转场：进行动画时重绘视图
 UIViewAnimationOptionShowHideTransitionViews   //转场：移除（添加和移除图层的）动画效果
 UIViewAnimationOptionOverrideInheritedOptions  //不继承父动画设置
 
 UIViewAnimationOptionCurveEaseInOut            //时间曲线，慢进慢出（默认值）
 UIViewAnimationOptionCurveEaseIn               //时间曲线，慢进
 UIViewAnimationOptionCurveEaseOut              //时间曲线，慢出
 UIViewAnimationOptionCurveLinear               //时间曲线，匀速
 
 UIViewAnimationOptionTransitionNone            //转场，不使用动画
 UIViewAnimationOptionTransitionFlipFromLeft    //转场，从左向右旋转翻页
 UIViewAnimationOptionTransitionFlipFromRight   //转场，从右向左旋转翻页
 UIViewAnimationOptionTransitionCurlUp          //转场，下往上卷曲翻页
 UIViewAnimationOptionTransitionCurlDown        //转场，从上往下卷曲翻页
 UIViewAnimationOptionTransitionCrossDissolve   //转场，交叉消失和出现
 UIViewAnimationOptionTransitionFlipFromTop     //转场，从上向下旋转翻页
 UIViewAnimationOptionTransitionFlipFromBottom  //转场，从下向上旋转翻页
 */

- (void)transitionAnimation {
    [UIView transitionWithView:self.anView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        //self.anView.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
        [UIView transitionWithView:self.anView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            //self.anView.backgroundColor = [UIColor greenColor];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)viewDelegateAnimation {
    //开始动画
    [UIView beginAnimations:@"delegate_animation" context:nil];
    //设置延后时间
    [UIView setAnimationDelay:0];
    //设置动画执行时间
    [UIView setAnimationDuration:2];
    /*
     UIViewAnimationCurveEaseInOut,         // 开始和结束的时候慢
     UIViewAnimationCurveEaseIn,            // 开始的时候慢
     UIViewAnimationCurveEaseOut,           // 结束的慢
     UIViewAnimationCurveLinear             //匀速
     */
    //设置动画速度
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //设置代理
    [UIView setAnimationDelegate:self];
    
    //设置动画将要开始调用方法 ,方法可以自己定义  注意,设置此方法一定要设置代理,否则不会调用
    [UIView setAnimationWillStartSelector:@selector(willstart)];
    
    //动画重复次数
    [UIView setAnimationRepeatCount:1];
    //沿路线折返
    [UIView setAnimationRepeatAutoreverses:YES];
    
    //是否支持动画
    [UIView setAnimationsEnabled:YES];
    
    //位置变换
    //    self.animaitonView.frame = CGRectMake(80, 306, 160, 63);
    
    //旋转角度两种
    //self.animaitonView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
    self.anView.transform = CGAffineTransformRotate(self.anView.transform, M_PI/2.0);
    
    
    //动画过度动画,执行过度动画后,视图的属性值,直接改变
    //    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    
    //动画结束
    [UIView commitAnimations];
}

- (void)willstart {
    NSLog(@"动画将要开始");
}

- (void)imageViewFrameAnimation {
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"animationIcon_%d", i]];
        [imageArray addObject:image];
    }
    self.anView.animationImages = imageArray;
    self.anView.animationDuration = 1.0;
    // 0表示无限循环
    self.anView.animationRepeatCount = 0;
    [self.anView startAnimating];
}

- (IBAction)click:(id)sender {
    switch (self.type) {
        case 0:
            [self changeFrame];
            break;
        case 1:
            [self changeBounds];
            break;
        case 2:
            [self changeCenter];
            break;
        case 3:
            [self transform];
            break;
        case 4:
            [self alpha];
            break;
        case 5:
            [self changeBackground];
            break;
        case 6:
            [self springAnimation];
            break;
        case 7:
            [self transitionAnimation];
            break;
        case 8:
            [self viewDelegateAnimation];
            break;
        case 9:
            [self imageViewFrameAnimation];
            break;
            
        default:
            break;
    }
}

@end
