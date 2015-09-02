//
//  LPPopViewController.m
//  LPPopViewDemo
//
//  Created by MacBook on 15/9/2.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import "LPPopViewController.h"

typedef void(^selectionBlock)(NSDictionary *selectionItem);

@interface LPPopViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIImageView *backgroundImage;

@property (nonatomic, assign) CGRect showFrame;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) selectionBlock selectionBlock;

@end

@implementation LPPopViewController

static NSString * const reuseIdentifier = @"Cell";

+ (instancetype)shareInstance
{
    static dispatch_once_t t;
    static LPPopViewController *pop;
    dispatch_once(&t, ^{
        pop = [[LPPopViewController alloc] init];
    });
    
    return pop;
}

- (instancetype) initWithItems:(NSArray *)items completion:(void (^)(NSDictionary *))completion
{
    self = [super init];
    if (self) {
        _items = [NSArray array];
        _items = items;
        _selectionBlock = completion;
    }
    return self;
}

- (void)showInView:(UIView *)view frame:(CGRect)frame
{
//    CGFloat left = frame.origin.x;
//    CGFloat top = frame.origin.y;
//    CGFloat width = frame.size.width;
    _showFrame = frame;
    [view.window.rootViewController addChildViewController:self];
    CGFloat mainTop = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    self.view.frame = CGRectMake(frame.origin.x, mainTop + frame.origin.y, frame.size.width, frame.size.height);
    self.view.backgroundColor = [UIColor clearColor];
    if ([view.window.subviews containsObject:self.view]) {
        self.view.hidden = !self.view.hidden;
        return;
    }
    self.view.hidden = NO;
    [view.window addSubview:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImage = [[UIImageView alloc] init];
    self.backgroundImage.image = [UIImage imageNamed:@"pop"];
    self.backgroundImage.frame = CGRectMake(0, - 5, _showFrame.size.width + 10, _showFrame.size.height + 5);
    [self.view addSubview:self.backgroundImage];
    CGRect tableFrame = CGRectInset(self.backgroundImage.bounds, 10, 13);
    self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *dic = _items[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", dic.allKeys.firstObject];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
//    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.view.hidden = YES;
    NSDictionary *dict = self.items[indexPath.row];
    !_selectionBlock ?: _selectionBlock(dict);
}

@end
