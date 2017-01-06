//
//  PopAnimationController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/6.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "PopAnimationController.h"
#import "PopAnimationDetailController.h"

@interface PopAnimationController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation PopAnimationController {
    UITableView *_tableView;
    NSArray *_titleArray;
}

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"POPBasicAnimation", @"POPSpringAnimation", @"POPDecayAnimation", @"POPCustomAnimation"];
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
    PopAnimationDetailController *vc = [[PopAnimationDetailController alloc] init];
    vc.type = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
