//
//  GoodsDetailViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/16.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking/AFNetworking.h>

#import "CartDetail.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "UIImageView+WebCache.h"

@interface GoodsDetailViewController : UIViewController<MBProgressHUDDelegate>

@property(strong,nonatomic)NSNumber *_sid;

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)UIScrollView *_mainScrollView;

@end
