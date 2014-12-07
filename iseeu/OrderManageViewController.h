//
//  OrderManageViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Color.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

@interface OrderManageViewController : UIViewController<MBProgressHUDDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)NSString *_uid;

@property(nonatomic)CGFloat _width;

@property(strong,nonatomic)UIView *_activeView;

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)UIScrollView *_mainScrollView;

@end
