//
//  CustomPresentViewController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CustomAnimationController.h"
#import "UIViewController+CustomTransitionAnimation.h"

@interface CustomAnimationController ()

@end

@implementation CustomAnimationController

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self mmInitViews];
}

#pragma mark - initViews

- (void)mmInitViews {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)dismissAction:(UIButton *)sender {
    if (_type == 0) {
        [self customDismissViewController];
    } else if (_type == 1) {
        CATransition *transition = [CATransition animation];
        transition.duration = .35;
        transition.timingFunction = UIViewAnimationCurveEaseInOut;
        transition.type = @"cube";
        transition.subtype = kCATransitionFromLeft;
        
        [self customPopViewControllerWithTransition:transition];
    }
}
@end
