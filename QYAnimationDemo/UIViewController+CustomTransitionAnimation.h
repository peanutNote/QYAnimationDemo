//
//  UIViewController+CustomPresentAnimation.h
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomTransitionAnimation)

- (void)customPresentViewController:(UIViewController *)viewController;

- (void)customDismissViewController;

- (void)customPushViewControllerWihtTransition:(CATransition *)transition viewController:(UIViewController *)viewController;

- (void)customPopViewControllerWithTransition:(CATransition *)transition;

@end
