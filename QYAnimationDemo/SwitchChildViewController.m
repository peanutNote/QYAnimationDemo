//
//  SwitchChildViewController.m
//  QYAnimationDemo
//
//  Created by qianye on 17/1/5.
//  Copyright © 2017年 qianye. All rights reserved.
//

#import "SwitchChildViewController.h"

@interface SwitchChildViewController ()

@property (nonatomic, strong) UIViewController *firstVC;
@property (nonatomic, strong) UIViewController *secondVC;
@property (nonatomic, strong) UIViewController *thirdVC;
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) UIScrollView *headScrollView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation SwitchChildViewController

#pragma mark - ViewController Method

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _itemArray = [NSMutableArray arrayWithObjects:@"头条",@"今日",@"焦点", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self mmInitViews];
}

#pragma mark - initViews

- (void)mmInitViews {
    _headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44 + 64)];
    _headScrollView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    for (int i = 0; i < _itemArray.count; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.frame = CGRectMake(i * (kScreenWidth / _itemArray.count), 0, kScreenWidth/_itemArray.count, 44);
        itemButton.tag = 100 + i;
        itemButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [itemButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [itemButton setTitle:_itemArray[i] forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headScrollView addSubview:itemButton];
    }
    _headScrollView.showsHorizontalScrollIndicator = NO;
    _headScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_headScrollView];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 44 + 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 - 64)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
    [self addSubControllers];
}

#pragma mark - privatemethods

- (void)addSubControllers{
    _firstVC = [[UIViewController alloc] init];
    _firstVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:_firstVC];
    
    _secondVC = [[UIViewController alloc] init];
    _secondVC.view.backgroundColor = [UIColor cyanColor];
    [self addChildViewController:_secondVC];
    
    _thirdVC = [[UIViewController alloc] init];
    _thirdVC.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:_thirdVC];
    
    //调整子视图控制器的Frame已适应容器View
    [self fitFrameForChildViewController:_firstVC];
    //设置默认显示在容器View的内容
    [self.contentView addSubview:_firstVC.view];
    
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    NSLog(@"%@",NSStringFromCGRect(_firstVC.view.frame));
    
    _currentVC = _firstVC;
}

- (void)buttonClick:(UIButton *)sender{
    if ((sender.tag == 100 && _currentVC == _firstVC) || (sender.tag == 101 && _currentVC == _secondVC) || (sender.tag == 102 && _currentVC == _thirdVC)) {
        return;
    }
    switch (sender.tag) {
        case 100:{
            [self fitFrameForChildViewController:_firstVC];
            [self transitionFromOldViewController:_currentVC toNewViewController:_firstVC];
        }
            break;
        case 101:{
            [self fitFrameForChildViewController:_secondVC];
            [self transitionFromOldViewController:_currentVC toNewViewController:_secondVC];
        }
            break;
        case 102:{
            [self fitFrameForChildViewController:_thirdVC];
            [self transitionFromOldViewController:_currentVC toNewViewController:_thirdVC];
        }
            break;
    }
}

- (void)fitFrameForChildViewController:(UIViewController *)chileViewController{
    CGRect frame = self.contentView.frame;
    frame.origin.y = 0;
    chileViewController.view.frame = frame;
}

//转换子视图控制器
- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController{
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.35 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            _currentVC = newViewController;
        }else{
            _currentVC = oldViewController;
        }
    }];
}

//移除所有子视图控制器
- (void)removeAllChildViewControllers{
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
}

/**
 *  方法说明：
 *  1、addChildViewController:向父VC中添加子VC，添加之后自动调用willMoveToParentViewController:父VC
 *  2、removeFromParentViewController:将子VC从父VC中移除，移除之后自动调用
 didMoveToParentViewController:nil
 *  3、willMoveToParentViewController:  当向父VC添加子VC之后，该方法会自动调用。若要从父VC移除子VC，需要在移除之前调用该方法，传入参数nil。
 *  4、didMoveToParentViewController:  当向父VC添加子VC之后，该方法不会被自动调用，需要显示调用告诉编译器已经完成添加（事实上不调用该方法也不会有问题，不太明白）; 从父VC移除子VC之后，该方法会自动调用，传入的参数为nil,所以不需要显示调用。
 */

/**
 *  注意点：
 要想切换子视图控制器a/b,a/b必须均已添加到父视图控制器中，不然会报错
 */
@end
