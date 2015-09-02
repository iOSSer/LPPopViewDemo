//
//  ViewController.m
//  LPPopViewDemo
//
//  Created by MacBook on 15/9/2.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "ViewController.h"
#import "LPPopViewController.h"

@interface ViewController ()

@property (nonatomic, strong) LPPopViewController *pop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *items = @[@{@"创建群": @"group_image"}, @{@"添加好友": @"add_image"},@{@"创建讨论组": @"conversion_image"}];
    _pop = [[LPPopViewController alloc] initWithItems:items completion:^(NSDictionary *selectionItem) {
        NSLog(@"%@", selectionItem);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(popAction)];
}

- (void) popAction
{
    CGFloat width = 150;
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width - width - 30, 10, width, 150);
    [_pop showInView:self.view frame:frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
