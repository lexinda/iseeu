//
//  SideViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/22.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Color.h"

#import "NSDate+TimeAgo.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "DetailTableView.h"

#import <AFNetworking/AFNetworking.h>

#import "RightViewModel.h"

@interface SideViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)UIScrollView *_contentView;

@property(nonatomic)CGFloat _width;

@property(strong,nonatomic)MBProgressHUD *_hud;

@end
