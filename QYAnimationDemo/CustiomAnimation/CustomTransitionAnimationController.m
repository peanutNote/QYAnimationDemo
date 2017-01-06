//
//  CustomTransitionAnimationController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CustomTransitionAnimationController.h"
#import "UIViewController+CustomTransitionAnimation.h"
#import "CustomAnimationController.h"
#import "SwitchChildViewController.h"

@interface CustomTransitionAnimationController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CustomTransitionAnimationController {
    UITableView *_tableView;
    NSArray *_titleArray;
}

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"自定义模态弹出动画", @"自定义导航栏push动画", @"有关ChildViewController的应用"];
    [self mmInitViews];
}

#pragma mark - initViews

- (void)mmInitViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSCreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    if (indexPath.row == 0) {
        CustomAnimationController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Custom"];
        vc.type = indexPath.row;
        [self customPresentViewController:vc];
    } else if (indexPath.row == 1) {
        // 创建动画
        CATransition *transition = [CATransition animation];
        transition.duration = .35;
        transition.timingFunction = UIViewAnimationCurveEaseInOut;
        transition.type = @"cube";
        transition.subtype = kCATransitionFromRight;
        
        CustomAnimationController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Custom"];
        vc.type = indexPath.row;
        [self customPushViewControllerWihtTransition:transition viewController:vc];
    } else {
        SwitchChildViewController *vc = [[SwitchChildViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
