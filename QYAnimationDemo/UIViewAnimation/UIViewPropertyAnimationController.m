//
//  UIViewPropertyAnimationController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "UIViewPropertyAnimationController.h"
#import "UIViewAnimationDetailController.h"

@interface UIViewPropertyAnimationController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation UIViewPropertyAnimationController {
    UITableView *_tableView;
    NSArray *_titleArray;
}

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"大小变化(frame)", @"拉伸变化(bounds)", @"中心位置变化(center)", @"旋转等(transform)", @"透明度(alpha)", @"背景颜色(backgroundColor)", @"Spring动画", @"转场动画", @"UIView代理动画(delegate)", @"UIImageView帧动画"];
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewAnimationDetailController *vc = [storyboard instantiateViewControllerWithIdentifier:@"vc_detail"];
    vc.type = indexPath.row;
    vc.title = _titleArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
