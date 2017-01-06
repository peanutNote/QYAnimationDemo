//
//  ViewController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "ViewController.h"
#import "UIViewPropertyAnimationController.h"
#import "CATransitionAnimationController.h"
#import "CustomTransitionAnimationController.h"
#import "CAAnimationController.h"
#import "PopAnimationController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController {
    UITableView *_tableView;
    NSArray *_titleArray;
}

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"UIView属性动画", @"CATransition动画", @"CAAnimation动画", @"自定义过场动画", @"pop简单使用"];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIViewPropertyAnimationController *vc = [[UIViewPropertyAnimationController alloc] init];
        vc.title = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"transition"];
        vc.title = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        CAAnimationController *vc = [[CAAnimationController alloc] init];
        vc.title = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        CustomTransitionAnimationController *vc = [[CustomTransitionAnimationController alloc] init];
        vc.title = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        PopAnimationController *vc = [[PopAnimationController alloc] init];
        vc.title = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
