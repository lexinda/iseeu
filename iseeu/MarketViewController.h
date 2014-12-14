//
//  MarketViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/10.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking/AFNetworking.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import "UIButton+WebCache.h"

#import "ScroeMarketViewController.h"

#import "FootView.h"

#import "ClassificationViewController.h"

#import "UserInfoViewController.h"

#import "CartDetailViewController.h"

#import "ViewController.h"

@interface MarketViewController : UIViewController<MBProgressHUDDelegate,UIScrollViewDelegate,FootPushViewDelegate>

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)UIScrollView *_brandScrollView;

@property(strong,nonatomic)UIButton *_oneButton;

@property(nonatomic)CGFloat _brandScrollHeight;

@end
