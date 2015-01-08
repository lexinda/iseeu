//
//  MoreViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 15/1/8.
//  Copyright (c) 2015年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserInfoViewController.h"

#import "CartDetailViewController.h"

#import "MarketViewController.h"

#import "EyeColorViewController.h"

#import "FootView.h"

#import <AFNetworking/AFNetworking.h>

#import <SDWebImage/UIImageView+WebCache.h>

@interface MoreViewController : UIViewController<FootPushViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *_aboutTableView;

@property(strong,nonatomic)NSArray *_tableArray;

@end
