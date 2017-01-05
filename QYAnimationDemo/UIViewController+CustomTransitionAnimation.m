//
//  UIViewController+CustomPresentAnimation.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "UIViewController+CustomTransitionAnimation.h"

@implementation UIViewController (CustomTransitionAnimation)

- (void)customPresentViewController:(UIViewController *)viewController {
    viewController.view.frame = CGRectMake(kScreenWidth,0,kScreenWidth,kSCreenHeight);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:viewController.view];
    [UIView animateWithDuration:.35 animations:^{
        if (self.navigationController) {
            self.navigationController.view.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kSCreenHeight);
        } else {
            self.view.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kSCreenHeight);
        }
        viewController.view.frame = CGRectMake(0, 0, kScreenWidth, kSCreenHeight);
    }];
    [self addChildViewController:viewController];
}

- (void)customDismissViewController {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:.35 animations:^{
        self.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kSCreenHeight);
        window.rootViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kSCreenHeight);
    }];
    [self removeFromParentViewController];
}

- (void)customPushViewControllerWihtTransition:(CATransition *)transition viewController:(UIViewController *)viewController; {
    if (self.navigationController) {
        [self.navigationController.view.layer addAnimation:transition forKey:@"animaiton"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)customPopViewControllerWithTransition:(CATransition *)transition {
    if (self.navigationController) {
        [self.navigationController.view.layer addAnimation:transition forKey:@"animaiton"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
