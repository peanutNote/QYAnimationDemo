//
//  CAAnimationController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "CAAnimationController.h"
#import "CAAnimationDetailController.h"
#import "CATransactionAnimationController.h"

@interface CAAnimationController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CAAnimationController {
    UITableView *_tableView;
    NSArray *_titleArray;
}

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"CABasicAnimation动画", @"CAKeyframeAnimation动画", @"CAAnimationGroup动画", @"CASpringAnimation动画", @"CATransaction事物动画", @"路径结合动画实例", @"DisplayLink结合动画"];
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
    if (indexPath.row == 4) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CATransactionAnimationController *vc = [storyboard instantiateViewControllerWithIdentifier:@"transaction"];
        vc.title = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        CAAnimationDetailController *vc = [[CAAnimationDetailController alloc] init];
        vc.title = _titleArray[indexPath.row];
        vc.type = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
