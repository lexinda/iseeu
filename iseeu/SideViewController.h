//
//  SideViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/22.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Color.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "DetailTableView.h"

#import <AFNetworking/AFNetworking.h>

#import "RightViewModel.h"

#import "ClassificationViewController.h"

@interface SideViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,HomeDelegate>

@property(strong,nonatomic)UIScrollView *_contentView;

@property(nonatomic)CGFloat _width;

@property(strong,nonatomic)MBProgressHUD *_hud;

@end
