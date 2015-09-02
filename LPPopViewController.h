//
//  LPPopViewController.h
//  LPPopViewDemo
//
//  Created by MacBook on 15/9/2.
//  Copyright (c) 2015年 lipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPopViewController : UIViewController

+ (instancetype) shareInstance;

- (instancetype) initWithItems:(NSArray *)items completion:(void (^)(NSDictionary *selectionItem))completion;

- (void) showInView:(UIView *)view frame:(CGRect) frame;
@end
